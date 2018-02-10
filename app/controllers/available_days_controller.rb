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

    @availableDay = AvailableDay.where('date = ? AND user_id = ?', available_days_params[:date], available_days_params[:user_id])
    if @availableDay.length >= 1
      @deldate = @availableDay[0]
      @availableDay[0].destroy
      respond_to do |format|
        format.html {redirect_to new_user_available_day_path(@user)}
        format.js {render 'new_del'}
      end
    elsif @availableDay.length <= 1
      @availableDay = AvailableDay.create(available_days_params)
      arr = ["08:00:00","09:00:00","10:00:00","11:00:00","12:00:00","1:00:00","2:00:00","3:00:00","4:00:00","5:00:00","6:00:00","7:00:00","8:00:00"]
      arr.each do |time|
        @time = @availableDay.available_times.find_or_create_by(time: time)
      end

      respond_to do |format|
        format.html {redirect_to new_user_available_day_path(@user)}
        format.js {render 'new'}
      end
    else
      redirect_to "new"
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
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  private
  def available_days_params
    params.require(:available_day).permit(:user_id, :comment, :date)
  end
end
