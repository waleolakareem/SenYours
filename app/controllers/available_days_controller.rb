class AvailableDaysController < ApplicationController
  def index

  end

  def new
    @user = current_user
    @available_day = AvailableDay.new
    @current_date = current_user.available_days
  end

  def create
    p "*" * 10
    p params
    p available_days_params
    p "*" * 10
    @user = current_user
    @availableDay = AvailableDay.new(available_days_params)
    @current_date = current_user.available_days
    if @availableDay.save
      arr = ["10:00:00","11:00:00","12:00:00","1:00:00","2:00:00","3:00:00","4:00:00","5:00:00","6:00:00","7:00:00","8:00:00"]
      arr.each do |time|
        @time = @availableDay.available_times.create(time: time)
      end
      redirect_to new_user_available_day_path(@user)
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

  end

  private
  def available_days_params
    p "&&&&&&&&&&&&"
    p params[:user_id]
    params.permit(:user_id, :comment, :date)
  end
end
