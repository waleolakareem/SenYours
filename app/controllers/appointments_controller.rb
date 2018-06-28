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

      # For reference all Stripe values are done in the smallest currency. I.E. USA cents. 1000 cents = $10.
      # total_fees = ((Companion's Hourly Fee * 100) * Time) * 20%[SenYours Transaction Fee] + 0.25%(Stripe Net Total Transaction Fee)
      total_fees = (((@appointment.companion.fee * 100) * time) * 0.2025).floor
      total_senior_cost = ((@appointment.companion.fee * 100) * time)
      total_companion_payout = total_senior_cost - total_fees

      stripe_charge_response = Stripe::Charge.create({
        :amount => total_senior_cost,
        :currency => "usd",
        :source => "tok_visa",
        :destination => {
          :amount => total_companion_payout,
          :account => @appointment.companion.stripe_user_id,
        }
      })
      Transaction.create(
        stripe_transaction_id: stripe_charge_response.id,
        amount: total_senior_cost,
        fee: total_fees,
        payout: total_companion_payout,
        senior_id: @appointment.senior_id,
        companion_id: @appointment.companion_id,
        appointment_id: @appointment.id
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
    @transaction = Transaction.find_by_appointment_id(@appointment.id)
    # ADD refund and mark transaction as cancelled



    @appointment[0].destroy
    redirect_to user_path(@user)
  end

  private
  def appointment_params
    params.require(:appointment).permit(:start_time, :end_time, :start_date, :end_date, :senior_id, :companion_id, :fee, :accept, :payment_status)
  end
end
