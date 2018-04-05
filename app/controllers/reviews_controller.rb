class ReviewsController < ApplicationController
  def index
  end

  def new
    @user = User.find(params[:user_id])
    @review = Review.new
  end

  def create
    @user = User.find(params[:user_id])
    @review = Review.new(review_params)

    if @review.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  private
  def review_params
    params.require(:review).permit( :comment, :user_id, :reviewer_id, :wyr_rating, :comm_rating, :comp_rating )
  end
end
