require 'json'
require 'carmen'
include Carmen
module UsersHelper
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  # helper_method :current_user

  def authorize
    redirect_to '/login' unless current_user
  end

  def back_user(user)
    require 'net/https'
    uri = URI "https://api.accuratebackground.com/v3/candidate/"

    clientId = ENV['clientId']
    clientSecret = ENV['clientSecret']

    params = {
      "firstName" => "#{@user.first_name}" ,
      "lastName" => "#{@user.last_name}",
      "phone" => "#{@user.phone_number}",
      "email" => "#{@user.email}",
      "dateOfBirth" => "#{@user.dob}",
      "ssn" => "#{@user.ssn}",
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

    clientId = ENV['clientId']
    clientSecret = ENV['clientSecret']

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
end
