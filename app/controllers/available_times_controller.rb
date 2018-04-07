class AvailableTimesController < ApplicationController
  def create
  end

  def destroy
  end

  private
  def available_times_params
    params.require(:available_time).permit(:available_day_id, :comment, :time)
  end
end
