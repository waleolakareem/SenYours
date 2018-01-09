class UsersController < ApplicationController
  def index
    @user = User.all
  end

  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to edit_user_path(@user)
    else
      redirect_to '/'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
  end


  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :address, :city, :zipcode, :state, :ssn, :phone_number, :avatar, :verification_image, :fee, :description, :email, :password, :password_confirmation, :age, :age_range, :identification, :availability)
    end
end
