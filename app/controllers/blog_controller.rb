class BlogController < ApplicationController

  def index
    @blogs = Blog.paginate(:page => params[:page], :per_page => 30).order("created_at DESC")
  end

  def show
    @blog = Blog.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
    redirect_to :blog_index, alert: 'Blog not found'
  end

  def password_input
  end

  def password_authenticate
    if params[:input][:password] == "blaine"
      session[:admin] = true
      redirect_to :blog_index
    else
      flash[:failure] = "Please try again."
      redirect_to :password_input
    end
  end

  def end_session
    session[:admin] = false
    redirect_to :blog_index
  end

  def new
    if session[:admin]
      @blog = Blog.new
    else
      redirect_to password_input_path
    end
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      flash[:success] = "Blog created succesfully."
      redirect_to @blog
    else
      flash[:success] = "Blog needs more information."
      redirect_to new_blog_path
    end
  end

  def edit
    if session[:admin]
      @blog = Blog.find(params[:id])
    else
      redirect_to password_input_path
    end
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update_attributes(blog_params)
      flash[:success] = "Blog succesfully updated."
      redirect_to @blog
    else
      flash[:success] = "Blog needs more information."
      redirect_to edit_blog_path
    end
  end

  def destroy
    if session[:admin]
      Blog.find(params[:id]).destroy
      flash[:success] = "Blog succesfully deleted."
      redirect_to :blog_index
    else
      redirect_to password_input_path
    end

  end

  private
    def blog_params
      params.require(:blog).permit(:title, :body, :image)
    end

end
