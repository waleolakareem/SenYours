require 'net/http'
require 'rest-client'
class AppointmentsController < ApplicationController
  protect_from_forgery :except => :stripe_webhook
  Stripe.api_key=ENV['STRIPE_SECRET_KEY']

  def list_transactions # Index
    respond_to do |format|
      format.html {redirect_to user_path(current_user)}
      format.js { render 'list_transactions'}
    end
  end

  def appointment_time_sheet
    # Opens specific dates Timesheet
    # params.require(:appointment).permit(:start_time, :end_time, :start_date, :end_date, :senior_id, :companion_id, :fee, :accept, :payment_status)
    @user = User.find(params[:user])
    @date = params[:appointment][:start_date]
    days = []
    @times = []
    # Get avail day ID's to find proper times
    AvailableDay.where(user_id: @user.id, date: @date).each do |day_item|
      days << day_item
    end
    # Get exact times from days per above method
    AvailableTime.where(available_day_id: days[0].id).each do |time_item|
      @times << time_item
    end
    # Now that I have all the time_items I no longer need @days.
    # I also need to track global start and end time variables to compare when trying to confirm appointment.
    respond_to do |format|
      format.html {redirect_to user_path(current_user)}
      format.js { render 'appointment_time_sheet'}
    end
  end

  def apt_time_display
    puts "RENDERED apt_time_display"
    @start_time_selected = ""
  end

  def close_appointment_time_sheet
    # Close Time Sheet
  end
  def selected_time
    @display_time = AvailableTime.find_by_id(params[:display_time])
    # Store the time object in the array for later comparison.
  end
  def unselected_time
    @display_time = AvailableTime.find_by_id(params[:display_time])
    # Remove the time object from the array.
  end
  def selectable_time
  end

  def create_appointment # Create
    selected_appointment = Appointment.create(appointment_params)
    # Here the times selected should be checked that they are all in a row.
    # If they are all in a row, proceed with creation and set Start and End times as listed.
    # If they are NOT all in a row, cancel the appointment creation and post suggestion that all times should be connected.
    # selected_appointment.start_time = ???
    # selected_appointment.end_time = ???
    Transaction.create(
      appointment_id: selected_appointment.id,
      senior_id: selected_appointment.senior_id,
      companion_id: selected_appointment.companion_id,
      status: "completed",
    )
    redirect_to user_path(params[:appointment][:companion_id])
  end

  def accept_appointment # Update
    @selected_appointment = Appointment.find_by_id(params[:appointment_id])
    selected_transaction = Transaction.find_by_appointment_id(params[:appointment_id])
    # Variable "time" is the amount of hours TOTAL based on the selected day and ALL SELECTED HOUR SLOTS.
    time = aval_time(current_user,@selected_appointment.senior,@selected_appointment.start_date).length
    if time <= 0
      # flash[:alert] = "Variable time = 0 in 'accept_appointment'. Please select times before accepting appointments."
      puts "HEY!!!!!!!!!!! - Variable time = 0 in 'accept_appointment'. Please select times before accepting appointments."
      respond_to do |format|
        format.html { redirect_to user_path(current_user) }
        format.js { redirect_to user_path(current_user) }
      end
    else
      @selected_appointment.update_attributes(accept: true)
      @accept_this_app = current_user.companions.where({accept: false}).order('start_date ASC')[0]
      # ~STRIPE~ For reference all Stripe values are done in the smallest currency. I.E. USA cents. 1000 cents = $10.
      # ~STRIPE~ total_fees = ((Companion's Hourly Fee * 100) * Time) * 20%[SenYours Transaction Fee] + 0.25%(Stripe Net Total Transaction Fee)
      # ~STRIPE~ The 'total_fees' is what the platform keeps after both the charge and transfer are complete.
      total_fees = (((@selected_appointment.companion.fee * 100) * time) * 0.4025).to_i
      total_senior_cost = ((@selected_appointment.companion.fee * 100) * time).to_i
      total_companion_payout = total_senior_cost - total_fees
      desc_time = DateTime.now
      # ~STRIPE~ Creates a "Charge" to the Senior, "Transfering" the Companion Payment automatically & retaining the remainder for Stripe Fees & SenYours Payment.
      stripe_charge_response = Stripe::Charge.create({
        :amount => total_senior_cost,
        :currency => "usd",
        :source => "tok_visa",
        :description => "Appointment#{@selected_appointment.id}_Senior#{@selected_appointment.senior_id}_Companion#{@selected_appointment.companion_id}_#{desc_time.strftime("%Y/%m/%d_%H:%M")}",
        :destination => {
          :amount => total_companion_payout,
          :account => "#{@selected_appointment.companion.stripe_user_id}",
        }
      })
      # Transactions show the user all past appointments using status codes: "cancelled", "completed"
      selected_transaction.update_attributes(
        stripe_charge_id: stripe_charge_response.id,
        appointment_id: @selected_appointment.id,
        amount: total_senior_cost,
        fee: total_fees,
        payout: total_companion_payout,
        senior_id: @selected_appointment.senior_id,
        companion_id: @selected_appointment.companion_id,
        status: "completed",
      )
      @selected_appointment.payment_status = "Paid"
      @selected_appointment.save
      respond_to do |format|
        format.html { redirect_to user_path(current_user) }
        format.js { render 'available_days/accepted' }
      end
    end
  end

  def decline_appointment # Destroy
    @selected_appointment = Appointment.find_by_id(params[:appointment_id])
    @selected_appointment.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user) }
      format.js { render 'available_days/declined' }
    end
  end

  def cancel_appointment
    # Destroy Appointment / Update Transaction / Refund Stripe Charge to Senior / Reverse Stripe Transfer to Comp
    @selected_appointment = Appointment.find_by_id(params[:appointment_id])
    selected_transaction = Transaction.find_by_appointment_id(params[:appointment_id])
    # ~STRIPE~ If the appointment is cancelled prior to the appointment, the transaction will refund the senior the full amount.
    stripe_refund_response = Stripe::Refund.create({
      :charge => selected_transaction.stripe_charge_id,
      :reverse_transfer => true,
    })
    # Transactions show the user all past appointments using status codes: "cancelled", "completed"
    selected_transaction.update_attributes(
      refund_id: stripe_refund_response.id,
      status: "cancelled"
    )
    @del_appt = @selected_appointment
    @selected_appointment.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user) }
      format.js { render 'available_days/cancelled' }
    end
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

  def comp_request
    @user = current_user
    @appointment = @user.companions.where({accept: false})
  end

  private
  def appointment_params
    params.require(:appointment).permit(:start_time, :end_time, :start_date, :end_date, :senior_id, :companion_id, :fee, :accept, :payment_status)
  end

end
