class BlogController < ApplicationController
  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
    redirect_to :root, alert: 'Blog not found'
  end

  def password
    #code
  end

  def new
    @blog = Blog.new

    # if correct_password
    #   # Entry to create a blog
    # else
    #   # Back to index with messages
    # end
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
