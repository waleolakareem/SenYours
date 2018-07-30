class AppointmentsController < ApplicationController
  Stripe.api_key=ENV['SECRET_KEY']

  def index
  end

  def new
    @user = User.find(params[:user_id])
    @appointment = Appointment.new
  end

  def create
    @user = User.find(params[:user_id])
    @appointment = Appointment.where('start_date = ? AND senior_id = ? AND companion_id = ?', appointment_params[:start_date], appointment_params[:senior_id],
      appointment_params[:companion_id])
    if @appointment.length >= 1

      selected_user = User.find(params[:user_id])
      selected_appointment = Appointment.find(@appointment[0].id)
      selected_transaction = Transaction.find_by_appointment_id(@appointment[0].id)
      # ~STRIPE~ If the appointment is cancelled prior to the appointment, the transaction will refund the senior the full amount.
      stripe_refund_response = Stripe::Refund.create(
        :charge => selected_transaction.stripe_charge_id,
      )
      # ~STRIPE~ Transfer Reversals remove the associated amount from the companions pending balance immidiately.
      transfer = Stripe::Transfer.retrieve("#{selected_transaction.stripe_transfer_id}")
      transfer.reversals.create({
        :amount => "#{selected_transaction.payout}",
      })

      Transaction.find(selected_transaction.id).update(refund_id: stripe_refund_response.id)

      @del_appt = @appointment[0]
      @appointment[0].destroy
      respond_to do |format|
        format.html {redirect_to user_path(@user)}
        format.js {render 'new_del'}
      end
    elsif @appointment.length <= 1
      @appointment = Appointment.create(appointment_params)
      respond_to do |format|
        format.html {redirect_to user_path(@user)}
        format.js {render 'new'}
      end
    else
      render :new
    end
  end

  def edit
    @user = current_user
    @senior = @appointment.senior
    @companion = @appointment.companion
  end

  def update
    @user = current_user
    @appointment = Appointment.find(params[:id])
    if appointment_params[:accept] === "false" # If the companion declined the appointment request.
      @appointment.destroy
      @appointment = @user.companions.where({accept: false})
      @accept_appoint = ".asspt2"
      @accept_this_app = @appointment[0]
      respond_to do |format|
        format.html {redirect_to '/comp_request'}
        format.js { render 'accept_req'}
      end
    elsif @appointment.update_attributes(appointment_params) # If the companion accepted the appointment request.
      # Variable "time" is the amount of hours TOTAL based on the selected day and ALL SELECTED HOUR SLOTS.
      time =  aval_time(current_user,@appointment.senior,@appointment.start_date).length
      @accept_this_app = @user.companions.where({accept: false}).order('start_date ASC')[0]

      # ~STRIPE~ For reference all Stripe values are done in the smallest currency. I.E. USA cents. 1000 cents = $10.
      # ~STRIPE~ total_fees = ((Companion's Hourly Fee * 100) * Time) * 20%[SenYours Transaction Fee] + 0.25%(Stripe Net Total Transaction Fee)
      total_fees = (((@appointment.companion.fee * 100) * time) * 0.2025).floor
      total_senior_cost = ((@appointment.companion.fee * 100) * time)
      total_companion_payout = total_senior_cost - total_fees
      transfer_group = "Senior#{@appointment.senior_id}_Companion#{@appointment.companion_id}_Appointment#{@appointment.id}"
      desc_time = DateTime.now

      # ~STRIPE~ The 'total_fees' is what the platform keeps after both the charge and transfer are complete.

      # ~STRIPE~ Create a Charge to the Senior, sending the funds to the SenYours Platform Account Balance.
      stripe_charge_response = Stripe::Charge.create({
        :amount => total_senior_cost,
        :currency => "usd",
        :source => "tok_visa", # 'tok_visa' is used for testing. Change to Users actual card prior to production.
        :description => "Senior Appointment Charge: #{desc_time.strftime("%d/%m/%Y %H:%M")}",
      })

      # ~STRIPE~ Create a Transfer to the Companion using funds in SenYours Platform Account Balance AFTER they become available via 'source_transaction'.
      stripe_transfer_response = Stripe::Transfer.create({
        :amount => total_companion_payout,
        :currency => "usd",
        :destination => "#{@appointment.companion.stripe_user_id}",
        :source_transaction => "#{stripe_charge_response.id}",
        :description => 'Companion Payment Transfer',
      })

      Transaction.create(
        stripe_charge_id: stripe_charge_response.id,
        stripe_transfer_id: stripe_transfer_response.id,
        appointment_id: @appointment.id,
        amount: total_senior_cost,
        fee: total_fees,
        payout: total_companion_payout,
        senior_id: @appointment.senior_id,
        companion_id: @appointment.companion_id,
      )

        @accept_appoint = ".asspt1"
        @appointment.payment_status = "Paid"
        @appointment.save
        @appointment = @user.companions.where({accept: false})
        respond_to do |format|
          format.html {redirect_to '/comp_request'}
          format.js { render 'accept_req'}
        end
    else
      render 'edit'
    end
  end

  def show
  end

  def comp_request
    @user = current_user
    @appointment = @user.companions.where({accept: false})
  end

  def destroy
    @user = User.find(params[:user_id])
    @appointment = Appointment.where({senior_id: current_user,start_date: params[:id],companion_id: params[:user_id]})
    @appointment[0].destroy
    redirect_to user_path(@user)
  end

  private
  def appointment_params
    params.require(:appointment).permit(:start_time, :end_time, :start_date, :end_date, :senior_id, :companion_id, :fee, :accept, :payment_status)
  end

end
