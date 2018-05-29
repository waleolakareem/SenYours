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
    puts "password_input route"
  end

  def password_authenticate
    if params[:input][:password] == "1234"
      redirect_to :new_blog
    else
      flash[:success] = "Please try again."
      redirect_to :password_input
    end
  end

  def new
    # INSECURE - Needs sessions of some kind.
    # Can currently be accessed by typing in URL '/blog/new'
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      flash[:success] = "Blog created succesfully"
      redirect_to @blog
    else
      render new_user_path
    end
  end

  def edit
  end

  def delete
  end

  private
    def blog_params
      params.require(:blog).permit(:title, :body)
    end

end
