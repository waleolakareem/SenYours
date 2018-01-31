class UsersController < ApplicationController
 before_action :authorize, only: [:edit, :show]

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
      render 'new'
    end

    respond_to do |format|
      format.html {}
      format.js {}
     end
  end

  def edit
    @user = User.find(params[:id])
    p current_user
    p @user
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      if @user.identification === 'Companion' && !@user.accurate_customer_id
        back_user(@user)
        place_order(@user)
      end
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @companions = @user.companions.where("start_date >= ?",Date.today).order('start_date ASC')
    @seniors = @user.seniors.where("start_date >= ?",Date.today).order('start_date ASC')
  end

  def destroy
  end


  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :address, :city, :zipcode, :state, :ssn, :phone_number, :avatar, :verification_image, :fee, :description, :email, :password, :password_confirmation, :age, :age_range, :identification, :availability,:dob)
    end
end
