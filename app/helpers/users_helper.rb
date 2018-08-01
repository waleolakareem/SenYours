require 'json'
require 'carmen'
include Carmen
module UsersHelper
  def back_user(user)
    require 'net/https'
    uri = URI "https://api.accuratebackground.com/v3/candidate/"

    clientId = ENV['ACCURATE_BACKGROUND_CLIENT_ID']
    clientSecret = ENV['ACCURATE_BACKGROUND_CLIENT_SECRET']

    params = {
      "firstName" => "#{@user.first_name}" ,
      "lastName" => "#{@user.last_name}",
      "phone" => "#{@user.phone_number}",
      "email" => "#{@user.email}",
      "dateOfBirth" => "#{@user.dob}",
      "address" => "#{@user.address}",
      "city" => "#{@user.city}",
      "region" => "#{@user.state}",
      "country" => "US"
    }

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    req = Net::HTTP::Post.new(uri.path) # or any other request you might like
    req.basic_auth clientId,clientSecret
    req.set_form_data(params)

    resp = http.request(req)
    puts resp.body
    response = JSON.parse(resp.body)
    user.accurate_customer_id = response["id"]
    user.save!
  end

  def place_order(user)
    require 'net/https'
    uri = URI "https://api.accuratebackground.com/v3/order/"

    clientId = ENV['ACCURATE_BACKGROUND_CLIENT_ID']
    clientSecret = ENV['ACCURATE_BACKGROUND_CLIENT_SECRET']

    params = {
      "candidateId" => "#{@user.accurate_customer_id}",
      "packageType" => "PKG_BASIC" ,
      "workflow" => "INTERACTIVE",
      "jobLocation.city" => "#{@user.city}",
      "jobLocation.region" => "#{@user.state}",
      "jobLocation.country" => "US"
    }

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    req = Net::HTTP::Post.new(uri.path) # or any other request you might like
    req.basic_auth clientId,clientSecret
    req.set_form_data(params)

    resp = http.request(req)
    puts resp.body
  end

  def us_states
    [:CA]
  end

  # def cities
  #   render json: CS.cities(params[:state], :us).to_json
  # end

  def cities
    CS.get :us, :ca
  end

  def only_us_and_canada
    Carmen::Country.all.select{|c| %w{US CA}.include?(c.code)}
  end

  def send_message(user)
    require 'rubygems' # not necessary with ruby 1.9 but included for completeness
    require 'twilio-ruby'

    # put your own credentials here
    account_sid = ENV['account_sid']
    auth_token = ENV['auth_token']

    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    message = @client.messages.create(
      body: 'Welcome to Senyours!!!. Check your email to activate your account, so we can start this journey together',
      to: "#{user.phone_number}",
      from: '+16125004243',
    )

    puts message.sid
  end

  def survey_complete(user)
    require 'rest-client'
    result = ENV['resultId']
    user = user.email
    url = "http://api.dxsurvey.com/api/Survey/isCompleted?resultId=#{result}&clientId=#{user}"
    response = RestClient.get(url, headers={})
    response = JSON.parse(response.body)
    current_user.assessment = response
    current_user.save!
  end

end
