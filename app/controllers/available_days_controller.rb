class AvailableDaysController < ApplicationController
  def index

  end

  def new
    @user = current_user
    @available_day = AvailableDay.new
    @current_date = current_user.available_days
    @availableDay = @current_date.where('user_id = current_user','date=date')
  end

  def create
    @user = current_user
    @current_date = current_user.available_days
    @availableDay = AvailableDay.find_or_create_by(available_days_params)
    if @availableDay.save
      arr = ["10:00:00","11:00:00","12:00:00","1:00:00","2:00:00","3:00:00","4:00:00","5:00:00","6:00:00","7:00:00","8:00:00"]
      arr.each do |time|
        @time = @availableDay.available_times.find_or_create_by(time: time)
      end
      redirect_to new_user_available_day_path(@user)
    elsif @availableDay
      @availableDay.destroy
    else
      redirect_to "new"
    end
      respond_to do |format|
        format.html {}
        format.js {}
      end
  end

  def edit

  end

  def update

  end

  def show

  end

  def destroy
    @availableDay = AvailableDay.where({user_id:current_user,date: params[:id]})
    @availableDay[0].destroy
    redirect_to new_user_available_day_path(current_user)
  end

  private
  def available_days_params
    params.require(:available_day).permit(:user_id, :comment, :date)
  end
end
