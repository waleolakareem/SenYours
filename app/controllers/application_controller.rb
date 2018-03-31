class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ReviewsHelper
  include UsersHelper
  include AvailableDaysHelper
  include MessagesHelper
  include AppointmentHelper
  around_action :with_timezone

  private

  def with_timezone
    timezone = Time.find_zone(cookies[:timezone])
    Time.use_zone(timezone) { yield }
  end
end
