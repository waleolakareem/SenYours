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
    if appointment_params[:accept] === "false"
      @appointment.destroy
      @appointment = @user.companions.where({accept: false})
      @accept_appoint = ".asspt2"
      @accept_this_app = @appointment[0]
      respond_to do |format|
        format.html {redirect_to '/comp_request'}
        format.js { render 'accept_req'}
      end
    elsif @appointment.update_attributes(appointment_params)
      # Variable "time" is the amount of hours TOTAL based on the selected day and ALL SELECTED HOUR SLOTS.
      time =  aval_time(current_user,@appointment.senior,@appointment.start_date).length
      @accept_this_app = @user.companions.where({accept: false}).order('start_date ASC')[0]
      @accept_appoint = ".asspt1"

      # total_fees = (Companion's Hourly Fee * Time) * 20%[SenYours Transaction Fee] + 0.25%(Stripe Net Total Transaction Fee)
      total_fees = ((@appointment.companion.fee * time) * 0.2025).round(2)
      total_senior_cost = (@appointment.companion.fee * time)
      total_companion_payout = total_senior_cost - total_fees


      puts "total_fees: #{total_fees}"
      puts "total_senior_cost: #{total_senior_cost}"
      puts "total_companion_payout: #{total_companion_payout}"
      puts "time variable in APPOINTMENTS#UPDATE: #{time}"

      puts "~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~!~"
      # Stripe.api_version
      # Stripe::Balance
      #
      charge = Stripe::Charge.create({
        :amount => total_senior_cost,
        :currency => "usd",
        :source => "tok_visa",
        :destination => {
          :amount => 1050,
          :account => @appointment.companion.stripe_user_id,
        }
      })
      puts "Charge: #{charge}"

      # HOLD FUNDS FOR 24 HOURS BEFORE PAYING TO COMP.
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
