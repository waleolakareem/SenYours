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
      response = Net::HTTP.post_form(uri, {"client_secret" => "#{ENV['SECRET_KEY']}", "code" => "#{returned_auth_code}", "grant_type" => "authorization_code"})
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
          # During development console Display of parameters.
          puts " =-!-=-!-=-!-=-!-=-!-=-!-=-!-=-!-=-!-=-!-="
          puts "response_access_token: #{response_access_token}"
          puts "response_livemode: #{response_livemode}"
          puts "response_refresh_token: #{response_refresh_token}"
          puts "response_token_type: #{response_token_type}"
          puts "response_stripe_publishable_key: #{response_stripe_publishable_key}"
          puts "response_stripe_user_id: #{response_stripe_user_id}"
          puts "response_scope: #{response_scope}"
          puts " =-!-=-!-=-!-=-!-=-!-=-!-=-!-=-!-=-!-=-!-="

          redirect_to user_path(returned_user_id)
    else
      # If this 'else' is activated, then it's likely the user tampered with the URI.
      render root_path
    end
  end

  def show
  end

  def stripe_charge
    @user = User.find(params[:id])
    Stripe.api_key = "#{ENV['SECRET_KEY']}"

    charge = Stripe::Charge.create({
      :amount => 1000,
      :currency => "usd",
      :source => "tok_visa",
    }, :stripe_account => "acct_1CdNBdIM1No79syh")
    redirect_to user_path(@user)
  end

end
