class AppointmentsController < ApplicationController
  def index
  end

  def new
    @user = User.find(params[:user_id])
    @appointment = Appointment.new
  end

  def create
    p "r" * 99
    p appointment_params
    @user = User.find(params[:user_id])
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      redirect_to user_path(@user)
    else
      render :new
    end
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def edit
    @appointment = Appointment.find(params[:id])
    @senior = @appointment.senior
    @companion = @appointment.companion
  end

  def update
    @appointment = Appointment.find(params[:id])
    if @appointment.accept === false
      @appointment.destroy
      redirect_to user_path(current_user)
    elsif @appointment.update_attributes(appointment_params)
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end
  def show

  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
  end

  private
    def appointment_params
      params.require(:appointment).permit(:start_time, :end_time, :start_date, :end_date, :senior_id, :companion_id, :fee, :accept)
    end
end
