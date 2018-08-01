require 'net/http'
require 'rest-client'

class TransactionsController < ApplicationController
  protect_from_forgery :except => :stripe_webhook
  Stripe.api_key=ENV['STRIPE_SECRET_KEY']

  def index
  end

  def new_available_time
  end

  def new_available_date
  end

  def new_appointment
  end

  def new_transaction
  end

  def calendar
    @user = User.find(params[:user_id])
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
  end

  def show
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

end
