class AppointmentsController < ApplicationController
  def index

  end

  def new
    @user = User.find(params[:user_id])
    @appointment = Appointment.new
  end

  def create
    @user = User.find(params[:user_id])
    @appointment = Appointment.new(appointment_params)

    if @appointment.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def edit

  end

  def show

  end

  def destroy

  end

  private
    def appointment_params
      params.require(:appointment).permit( :start_time, :end_time, :start_date, :end_date, :senior_id, :companion_id, :fee )
    end
end
