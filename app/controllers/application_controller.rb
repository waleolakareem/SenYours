class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ReviewsHelper
  include UsersHelper
  include AvailableDaysHelper
  include MessagesHelper
  include AppointmentHelper
  include SessionsHelper
  around_action :with_timezone

end
