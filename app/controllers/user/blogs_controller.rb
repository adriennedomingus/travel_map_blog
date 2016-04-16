class User::BlogsController < User::BaseController
  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      current_user.blogs << @blog
      redirect_to blog_path(@blog)
    else
      render :new
    end
  end

  private

    def blog_params
      params.require(:blog).permit(:title, :date, :content)
    end
end
