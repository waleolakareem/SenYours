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
    puts "~!~&?~&?~!@~!@~!@~!@~!@~@!~@~!@~!@~!@~!@~!@~!@~!@!~@~@!~@!~@~@!~@~@!~@~!@!~@~@!~@~!@!~@!~@!@!~@!~@!~!~@~!@"
    puts "Hello! Slack_Webhook Route Here!"
    puts "~!~!@~!@~!@~!@~!@~!@~!@~@!~@~!@~!@~!@~!@~!@~!@~!@!~@~@!~@!~@~@!~@~@!~@~!@!~@~@!~@~!@!~@!~@!@!~@!~@!~!~@~!@"
    uri = "https://hooks.slack.com/services/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"
    RestClient.post uri, {'text' => "bob"}.to_json, {content_type: :json, accept: :json}
    redirect_to root_path
  end

  def stripe_webhook
    event_json = JSON.parse(request.body.read)

    # puts "~!~&?~&?~&?~&?~&?~&?~&?&?!&?~&?~&?~&?~&?~&?~&?~&?!&?&?!&?!&?&?!&?&?!&?~&?!&?&?!&?~&?!&?!&?&?!&?!&?!~!&?~&?"
    # puts "Hello! Stripe_Webhook Route Here!"
    # puts "~!~&?~&?~&?~&?~&?~&?~&?&?!&?~&?~&?~&?~&?~&?~&?~&?!&?&?!&?!&?&?!&?&?!&?~&?!&?&?!&?~&?!&?!&?&?!&?!&?!~!&?~&?"
    uri = "https://hooks.slack.com/services/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"
    RestClient.post uri, {'text' => "#{event_json}"}.to_json, {content_type: :json, accept: :json}
    RestClient.post uri, {'text' => "#{response}"}.to_json, {content_type: :json, accept: :json}
    # puts "#{response}"
    status 200
    # redirect_to root_path
  end

end
