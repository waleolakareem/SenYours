class BlogController < ApplicationController
  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
    redirect_to :root, alert: 'Blog not found'
  end

  def new
  end

  def create
  end

  def edit
  end

  def delete
  end
end
