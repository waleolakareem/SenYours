class AvailableTimesController < ApplicationController
  def destroy
    @available_time = AvailableTime.find(params[:id])
    @available_time.destroy
    redirect_to new_user_available_day_path(current_user)
  end
end
