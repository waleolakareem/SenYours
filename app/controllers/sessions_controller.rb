class SessionsController < ApplicationController
  def new
  end

  def create
    # find by downcase email because of validation
    user = User.find_by_email(params[:email].downcase)
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      log_in user
      redirect_to user
    else
    # If user's login doesn't work, send them back to the login form.
      flash[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
end
