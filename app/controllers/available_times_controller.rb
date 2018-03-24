class AvailableTimesController < ApplicationController
  def create
  end

  def destroy
    # @available_time = AvailableTime.find(params[:id])
    # @available_time.destroy
    # redirect_to new_user_available_day_path(current_user)
  end

  private
  def available_times_params
    params.require(:available_time).permit(:available_day_id, :comment, :time)
  end
end
