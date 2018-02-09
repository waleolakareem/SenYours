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
    @next_appointment = @user.companions.where({accept: false}).first().id
    @appointment = Appointment.find(params[:id] || '#{@next_appointment}')
    @senior = @appointment.senior
    @companion = @appointment.companion
  end

  def update
    @appointment = Appointment.find(params[:id])
    p "e" * 99
    p appointment_params
    if appointment_params[:accept] === "false"
      @appointment.destroy
      redirect_to user_path(current_user)
    elsif @appointment.update_attributes(appointment_params)
      @amount = @appointment.companion.fee * 100
      charge = Stripe::Charge.create(
        :customer    => @appointment.senior.stripe_customer_id,
        :amount      => @amount,
        :description => 'Rails Stripe customer',
        :currency    => 'usd'
        )
      @appointment.payment_status = "Paid"
      @appointment.save
      redirect_to '/comp_request'
      respond_to do |format|
        format.html {}
        format.js {}
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

