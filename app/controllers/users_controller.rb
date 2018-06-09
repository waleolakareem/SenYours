class UsersController < ApplicationController
 before_action :authorize, only: [:index,:edit, :show,:update]

  def index
    unless params["search"]
      @user = User.all
    else
      @user=User.where("fee <= ? AND fee >= ? AND city = ? ", params[:search][:max_price],params[:search][:min_price],params[:search][:city])
    end
  end

  def new
    if current_user
      redirect_to user_path(current_user)
    end
    @user = User.new
  end

  def sen_new
    if current_user
      redirect_to user_path(current_user)
    end
    @user = User.new
  end

  def comp_new
    if current_user
      redirect_to user_path(current_user)
    end
    @user = User.new
  end

  def comp_test
  end

  def assesment
    redirect_to user_path(current_user)
  end

  def create
    @claim = params[:user][:identification]
    @user = User.new(user_params)
    image = MiniMagick::Image.open("app/assets/images/avatar_image.png")
    @user.avatar = image
    if @user.save
      @user.send_activation_email
      @user.send_signed_up_email

      # send_message(@user)
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
      # session[:user_id] = @user.id
      # redirect_to user_path(@user)
    elsif @claim === "Senior"
        render 'sen_new'
    elsif @claim === "Companion"
        render 'comp_new'
    end

    respond_to do |format|
      format.html {}
      format.js {}
     end
  end

  def edit
    @user = User.find(params[:id])
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
    if @user.assessment === "no" && @user.identification === "Companion"
      survey_complete(@user)
    end

    @reviews = @user.reviews.last(3)
    #If the end date is less than todays date and greater than 3 days ago
    @comp_write_review = @user.companions.where("end_date < ? AND payment_status = ? AND end_date > ?",Date.today, "Paid", 3.day.ago).last(5)
    @sen_write_review = @user.seniors.where("end_date < ? AND payment_status = ? AND end_date > ?",Date.today, "Paid", 3.day.ago).last(5)
    @companions = @user.companions.where("start_date >= ? AND accept = ?",Date.today, true).order('start_date ASC')
    @seniors = @user.seniors.where("start_date >= ? AND accept = ?",Date.today, true).order('start_date ASC')
    @appointment = @user.companions.where("start_date >= ? AND accept = ?",Date.today, false).order('start_date ASC')
    @accept_this_app = @appointment[0]
  end

  def select_task
    task_id = params[:task_id]
    User.find(params[:user_id]).tasks << Task.all[task_id.to_i - 1]
    @user = User.find(params[:user_id])
    redirect_to user_path(@user)
    respond_to do |format|
      format.js { render 'select_task.js.erb' }
    end
  end

  def unselect_task
    task_id = params[:task_id]
    User.find(params[:user_id]).tasks.destroy(task_id.to_i)
    @user = User.find(params[:user_id])
    redirect_to user_path(@user)
  end


  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :address, :city, :zipcode, :state, :ssn, :phone_number, :avatar, :verification_image, :fee, :description, :email, :password, :password_confirmation, :age, :age_range, :identification, :availability,:dob, :terms_of_service, :privacy_policy)
    end
    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
