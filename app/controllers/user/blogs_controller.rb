class User::BlogsController < User::BaseController
  before_action :require_user, except: [:index]

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      current_user.blogs << @blog
      @blog.update_attribute(:slug, @blog.title.parameterize)
      service = TwitterService.new(current_user)
      service.post_tweet(blog_url(@blog.slug))
      redirect_to blog_path(@blog.slug)
    else
      render :new
    end
  end

  def index
    user = User.find_by(id: params[:id])
    @blogs = Blog.where(user_id: user.id)
  end

  private

    def blog_params
      params.require(:blog).permit(:title, :date, :content)
    end
end
