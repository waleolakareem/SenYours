class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ReviewsHelper
  include UsersHelper
  include AvailableDaysHelper
  include MessagesHelper
  include AppointmentHelper
  include SessionsHelper
  around_action :with_timezone

  private

  def with_timezone
    timezone = Time.find_zone(cookies[:timezone])
    unless params[:id].present? && request.path==available_day_path
      Time.use_zone(timezone) { yield }
    else
       yield
    end
  end
end
