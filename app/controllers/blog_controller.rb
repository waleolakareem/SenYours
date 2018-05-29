class BlogController < ApplicationController

  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
    redirect_to :root, alert: 'Blog not found'
  end

  def password_input
  end

  def password_authenticate
    if params[:input][:password] == "111"
      session[:admin] = true
      puts session[:admin]
      redirect_to :blog_index
    else
      flash[:failure] = "Please try again."
      redirect_to :password_input
    end
  end

  def end_session
    session[:admin] = false
    puts session[:admin]
    redirect_to :blog_index
  end

  def new
    # INSECURE - Needs sessions of some kind.
    # Can currently be accessed by typing in URL '/blog/new'
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      flash[:success] = "Blog created succesfully."
      redirect_to @blog
    else
      render new_user_path
    end
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update_attributes(blog_params)
      flash[:success] = "Blog succesfully updated."
      redirect_to root_path
    else
      redirect_to edit_user_path
    end
  end

  def destroy
    Blog.find(params[:id]).destroy
    flash[:success] = "Blog succesfully deleted."
    redirect_to :blog_index
  end

  private
    def blog_params
      params.require(:blog).permit(:title, :body)
    end

end
