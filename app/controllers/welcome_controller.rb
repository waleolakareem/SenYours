class WelcomeController < ApplicationController
  def index
    if current_user
      redirect_to user_path(current_user)
    end
  end

  def be_a_comp
  end

  def need_a_comp
  end

  def privacy_policy
  end

  def cookie_policy
  end
end
