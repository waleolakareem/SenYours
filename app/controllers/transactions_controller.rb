class TransactionsController < ApplicationController
  protect_from_forgery :except => :stripe_webhook

  def index
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
  end

  def slack_webhook
    uri = "https://hooks.slack.com/services/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"
    RestClient.post uri, {'text' => "bob"}.to_json, {content_type: :json, accept: :json}
    redirect_to root_path
  end

  def stripe_webhook
    # To properly test this using the test functionality provided by Stripe, you must use 'ngrok' and add the Webhook endpoint through the tunnel generated.
    event_json = JSON.parse(request.body.read)
    RestClient.post "https://hooks.slack.com/services/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", {
      "attachments": [
          {
              "fallback": "#{event_json}",
              "color": '#439FE0', # '#439FE0'=>blue / 'good'=>green / 'warning'=>orange / 'danger'=>red
              "pretext": "Stripe Action Taken On SenYours", # Line above message and "color" sidebar.
              "title": "Action Type: #{params[:type]}",
              "title_link": "Information: ",
              "text": "",
              "fields": [
                  {
                      "title": "Amount Total:",
                      "value": "$#{event_json['data']['object']['amount']}",
                      "short": true
                  },
                  {
                      "title": "Amount Refunded:",
                      "value": "$#{event_json['data']['object']['amount_refunded']}",
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
