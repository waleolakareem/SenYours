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
    # State helps prevent CSRF attacks.
    if params[:state] == 'senyours_verification'
      user_auth_code = params[:code]
      params = {'box1' => 'Nothing is less important than which fork you use. Etiquette is the science of living. It embraces everything. It is ethics. It is honor. -Emily Post',
      'button1' => 'Submit'
      }
      x = Net::HTTP.post_form(URI.parse('http://www.interlacken.com/webdbdev/ch05/formpost.asp'), params)
      puts x.body

    else
      # FAIL REQUEST, ITS BEEN TAMPERED WITH
    end
  end

end
