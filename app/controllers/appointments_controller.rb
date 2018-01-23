class AppointmentsController < ApplicationController
  def index
  end

  def new
    @user = User.find(params[:user_id])
    @appointment = Appointment.new
  end

  def create
    @user = User.find(params[:user_id])
    @appointment = Appointment.find_or_create_by(appointment_params)
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
    p appointment_params
    @appointment = Appointment.find(params[:id])
    if appointment_params[:accept] === "false"
      @appointment.destroy
      redirect_to user_path(current_user)
    elsif @appointment.update_attributes(appointment_params)
      redirect_to '/comp_request'
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
      params.require(:appointment).permit(:start_time, :end_time, :start_date, :end_date, :senior_id, :companion_id, :fee, :accept)
    end
end
