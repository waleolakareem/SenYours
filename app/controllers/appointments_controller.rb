require 'net/http'
require 'rest-client'
class AppointmentsController < ApplicationController
  protect_from_forgery :except => :stripe_webhook
  Stripe.api_key=ENV['STRIPE_SECRET_KEY']

# Begin Updated Routes
  def list_transactions # Index
  end

  def create_appointment # Create
    selected_appointment = Appointment.create(appointment_params)
    Transaction.create(
      appointment_id: selected_appointment.id,
      senior_id: selected_appointment.senior_id,
      companion_id: selected_appointment.companion_id,
      status: "completed",
    )
    redirect_to user_path(params[:appointment][:companion_id])
  end

  def accept_appointment # Update
    selected_appointment = Appointment.find_by_id(params[:appointment_id])
    selected_appointment.update_attributes(accept: true)
    selected_transaction = Transaction.find_by_appointment_id(params[:appointment_id])
    # Variable "time" is the amount of hours TOTAL based on the selected day and ALL SELECTED HOUR SLOTS.
    time = aval_time(current_user,selected_appointment.senior,selected_appointment.start_date).length
    @accept_this_app = current_user.companions.where({accept: false}).order('start_date ASC')[0]
    # ~STRIPE~ For reference all Stripe values are done in the smallest currency. I.E. USA cents. 1000 cents = $10.
    # ~STRIPE~ total_fees = ((Companion's Hourly Fee * 100) * Time) * 20%[SenYours Transaction Fee] + 0.25%(Stripe Net Total Transaction Fee)
    # ~STRIPE~ The 'total_fees' is what the platform keeps after both the charge and transfer are complete.
    total_fees = (((selected_appointment.companion.fee * 100) * time) * 0.2025).to_i
    total_senior_cost = ((selected_appointment.companion.fee * 100) * time).to_i
    total_companion_payout = total_senior_cost - total_fees
    transfer_group = "Senior#{selected_appointment.senior_id}_Companion#{selected_appointment.companion_id}_Appointment#{selected_appointment.id}"
    desc_time = DateTime.now
    # ~STRIPE~ Create a Charge to the Senior, sending the funds to the SenYours Platform Account Balance.
    stripe_charge_response = Stripe::Charge.create({
      :amount => total_senior_cost,
      :currency => "usd",
      :source => "tok_visa", # 'tok_visa' is used for testing. Change to Users actual card prior to production.
      :description => "Senior Appointment Charge: #{desc_time.strftime("%d/%m/%Y %H:%M")}",
    })
    # ~STRIPE~ Create a Transfer to the Companion using funds in SenYours Platform Account Balance AFTER they become available via 'source_transaction'.
    stripe_transfer_response = Stripe::Transfer.create({
      :amount => total_companion_payout,
      :currency => "usd",
      :destination => "#{selected_appointment.companion.stripe_user_id}",
      :source_transaction => "#{stripe_charge_response.id}",
      :description => 'Companion Payment Transfer',
    })
    # Transactions show the user all past appointments using status codes: "cancelled", "completed"
    selected_transaction.update_attributes(
      stripe_charge_id: stripe_charge_response.id,
      stripe_transfer_id: stripe_transfer_response.id,
      appointment_id: selected_appointment.id,
      amount: total_senior_cost,
      fee: total_fees,
      payout: total_companion_payout,
      senior_id: selected_appointment.senior_id,
      companion_id: selected_appointment.companion_id,
      status: "completed",
    )
    @accept_appoint = ".asspt1"
    selected_appointment.payment_status = "Paid"
    selected_appointment.save
    selected_appointment = current_user.companions.where({accept: false})

    redirect_to user_path(current_user)
    # respond_to do |format|
    #   format.html {redirect_to '/comp_request'}
    #   format.js { render 'accept_req'}
    # end
  end

  def decline_appointment # Destroy
    selected_appointment = Appointment.find_by_id(params[:appointment_id])
    selected_appointment.destroy
    redirect_to user_path(current_user)
  end

  def cancel_appointment
    # Destroy Appointment / Update Transaction / Refund Stripe Charge to Senior / Reverse Stripe Transfer to Comp
    selected_appointment = Appointment.find_by_id(params[:appointment_id])
    selected_transaction = Transaction.find_by_appointment_id(params[:appointment_id])
    # ~STRIPE~ If the appointment is cancelled prior to the appointment, the transaction will refund the senior the full amount.
    stripe_refund_response = Stripe::Refund.create(
      :charge => selected_transaction.stripe_charge_id,
    )
    # ~STRIPE~ Transfer Reversals remove the associated amount from the companions pending balance immidiately.
    transfer = Stripe::Transfer.retrieve("#{selected_transaction.stripe_transfer_id}")
    transfer.reversals.create({
      :amount => "#{selected_transaction.payout}",
    })
    # Transactions show the user all past appointments using status codes: "cancelled", "completed"
    selected_transaction.update_attributes(
      refund_id: stripe_refund_response.id,
      status: "cancelled"
    )
    @del_appt = selected_appointment
    selected_appointment.destroy

    redirect_to user_path(current_user)
  end

  def slack_webhook
    uri = "https://hooks.slack.com/services/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"
    RestClient.post uri, {'text' => "bob"}.to_json, {content_type: :json, accept: :json}
    redirect_to root_path
  end

  def stripe_webhook
    # This route is a pre-defined route tht Stripe will use to send response JSON. It is a post-only route for Stripe.

    # Webhooks to setup
    # payout.created
    # payout.updated
    # payout.paid
    # payout.failed

    # To properly test this using the test functionality provided by Stripe, you must use 'ngrok' and add the Webhook endpoint through the tunnel generated. I.E. `../../ngrok http 3000`
    transaction_json = JSON.parse(request.body.read)
    RestClient.post "https://hooks.slack.com/services/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", {
      "attachments": [
          {
              "fallback": "#{transaction_json}",
              "color": '#439FE0', # '#439FE0'=>blue / 'good'=>green / 'warning'=>orange / 'danger'=>red
              "pretext": "Stripe Action Taken On SenYours", # Line above message and "color" sidebar.
              "title": "Action Type: #{params[:type]}",
              "title_link": "Information: ",
              "text": "",
              "fields": [
                  {
                      "title": "Amount Total:",
                      "value": "$#{transaction_json['data']['object']['amount']}",
                      "short": true
                  },
                  {
                      "title": "Amount Refunded:",
                      "value": "$#{transaction_json['data']['object']['amount_refunded']}",
                      "short": true
                  }
              ],
              "footer": "transactions_stripe_webhook_path",
          }
      ]
    }.to_json, {content_type: :json, accept: :json}
    render status: 200
  end

  def verify # OnBoarding for Stripe Users. Allows Senior/Companion to use Stripe through SenYours Platform.
    # For documentation see: https://stripe.com/docs/connect/oauth-reference#post-token
    if params[:state].include?('senyours_verification')
      # Auth code required for Stripe Authentication
      returned_auth_code = params[:code]
      # State helps prevent CSRF attacks.
      returned_state = params[:state]
      # User Id is regex'ed from State to reutrn user to proper user_path
      returned_user_id = returned_state.match(/\d/)
      # This authentication is required to get the user a stripe_user_id
      uri = URI.parse("https://connect.stripe.com/oauth/token")
      response = Net::HTTP.post_form(uri, {"client_secret" => "#{ENV['STRIPE_SECRET_KEY']}", "code" => "#{returned_auth_code}", "grant_type" => "authorization_code"})
          # All paramters passed back in the response are captured here.
          response_body = JSON.parse(response.body)
          response_access_token = response_body['access_token']
          response_livemode = response_body['livemode']
          response_refresh_token = response_body['refresh_token']
          response_token_type = response_body['token_type']
          response_stripe_publishable_key = response_body['stripe_publishable_key']
          response_stripe_user_id = response_body['stripe_user_id']
          response_scope = response_body['scope']
          # If there is an error, it will be recorded and displayed.
          response_error = response_body['error']
          response_error_description = response_body['error_description']
          # User instance is updated as soon as the stripe_user_id is received. This allows to the user to re-login later without keeping sensitive information in our database.
          User.where( id: "#{returned_user_id}".to_i ).update_all( stripe_user_id: response_stripe_user_id )
          redirect_to user_path(returned_user_id)
    else
      # If this 'else' is activated, then it's likely the user tampered with the URI.
      render root_path
    end
  end

# End Updated Routes


  def comp_request
    @user = current_user
    @appointment = @user.companions.where({accept: false})
  end

  private
  def appointment_params
    params.require(:appointment).permit(:start_time, :end_time, :start_date, :end_date, :senior_id, :companion_id, :fee, :accept, :payment_status)
  end

end
