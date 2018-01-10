class AvailableDaysController < ApplicationController
  def index

  end

  def new
    @user = current_user
    @available_day = AvailableDay.new
    @current_date = current_user.available_days
  end

  def create
    @user = current_user
    @availableDay = AvailableDay.new(available_days_params)
    @current_date = current_user.available_days
    if @availableDay.save
      redirect_to new_user_available_day_path(@user)
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

  end

  private
  def available_days_params
    params.require(:available_day).permit(:user_id, :comment, :date)
  end
end
