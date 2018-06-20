require 'net/http'

class ChargesController < ApplicationController

  Stripe.api_key=ENV['SECRET_KEY']

  def new
  end

  def create
    # Amount in cents
    @amount = 100
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )
    # Store customer stripe_customer_id if it does not exist
    if !current_user.stripe_customer_id
      current_user.stripe_customer_id = customer.id
      current_user.save!
    end

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end

  def verify
    if params[:state].include?('senyours_verification')
      # Auth code required for Stripe Authentication
      returned_auth_code = params[:code]
      # State helps prevent CSRF attacks.
      returned_state = params[:state]
      # User Id is regex'ed from State to reutrn user to proper user_path
      returned_user_id = returned_state.match(/\d/)
      # This authentication is required to get the user a stripe_user_id
      uri = URI.parse("https://connect.stripe.com/oauth/token")
      response = Net::HTTP.post_form(uri, {"client_secret" => "#{ENV['SECRET_KEY']}", "code" => "#{returned_auth_code}", "grant_type" => "authorization_code"})

      case response.code
      when 200..299 # Sucessful
          response_body = JSON.parse(response.body)
          response_access_token = response_body['access_token']
          response_livemode = response_body['livemode']
          response_refresh_token = response_body['refresh_token']
          response_token_type = response_body['token_type']
          response_stripe_publishable_key = response_body['stripe_publishable_key']
          response_stripe_user_id = response_body['stripe_user_id']
          response_scope = response_body['scope']
          flash[:success] = "Code is #{response.code}"
          redirect_to user_path(returned_user_id)
        when 300..399
          flash[:alert] = "Code is #{response.code}"
          redirect_to user_path(returned_user_id)
        when 400..499
          flash[:alert] = "Code is #{response.code}"
          redirect_to user_path(returned_user_id)
        when 500..599
          flash[:alert] = "Code is #{response.code}"
          redirect_to user_path(returned_user_id)
        when 600..699
          flash[:alert] = "Code is #{response.code}"
          redirect_to user_path(returned_user_id)
        else
          flash[:alert] = "Code is #{response.code}"
          redirect_to user_path(returned_user_id)
      end

    else
      # If this 'else' is activated, then it's likely the user tampered with the URI.
      render root_path
    end
  end

end
