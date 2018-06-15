require "uri"
require "net/http"

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
    puts 'MADE IT TO VERIFY'
    returned_auth_code = params[:code]
    returned_state = params[:state]
    puts "Auth: #{returned_auth_code}"
    puts "State: #{returned_state}"
    # State helps prevent CSRF attacks.
    if params[:state] == 'senyours_verification'
      puts "~~~~~ Sucessful State Check ~~~~~"
      redirect_to root_path
    else
      # FAIL REQUEST, ITS BEEN TAMPERED WITH
    end
  end

end
