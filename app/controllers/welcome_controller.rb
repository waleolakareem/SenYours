class WelcomeController < ApplicationController
  def index
    if current_user
      redirect_to user_path(current_user)
    end
  end

  def companion
  end

  def super_adult
  end

  def privacy_policy
  end

  def cookie_policy
  end

  def about_us
  end
end
