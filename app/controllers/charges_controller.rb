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
    puts "~!~!~ MADE IT TO VERIFY ~!~!~"
    returned_auth_code = params[:code]
    returned_state = params[:state]
    puts "~~~~~ Auth: #{returned_auth_code} ~~~~~"
    puts "~~~~~ State: #{returned_state} ~~~~~"
    # State helps prevent CSRF attacks.
    if params[:state] == 'senyours_verification'
      puts "~~~~~ Sucessful State Check ~~~~~"
      uri = URI.parse("https://connect.stripe.com/oauth/token")
      response = Net::HTTP.post_form(uri, {"client_secret" => "#{ENV['SECRET_KEY']}", "code" => "#{returned_auth_code}", "grant_type" => "authorization_code"})


      case response.code
        when 200 # Sucessful
          response_body = JSON.parse(response.body)
          response_access_token = response_body['access_token']
          response_livemode = response_body['livemode']
          response_refresh_token = response_body['refresh_token']
          response_token_type = response_body['token_type']
          response_stripe_publishable_key = response_body['stripe_publishable_key']
          response_stripe_user_id = response_body['stripe_user_id']
          response_scope = response_body['scope']
          flash[:success] = 'Code is 200+'
          render user_path(@user.id)
        when String
          flash[:success] = 'How?'
          render user_path(@user.id)
        else
          flash[:success] = 'Failure!'
          render user_path(@user.id)
      end

    else
      puts "///// FAILURE //////"
      # FAIL REQUEST, ITS BEEN TAMPERED WITH
    end
  end

end
