class User::BlogsController < User::BaseController
  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      current_user.blogs << @blog
      service = TwitterService.new(current_user)
      service.post_tweet(blog_url(@blog))
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
