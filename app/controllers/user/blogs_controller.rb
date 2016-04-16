class User::BlogsController < User::BaseController
  before_action :require_user, except: [:index]

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      current_user.blogs << @blog
      # service = TwitterService.new(current_user)
      # service.post_tweet(blog_url(@blog.slug))
      redirect_to blog_path(@blog.slug)
    else
      render :new
    end
  end

  def index
    user = User.find_by(id: params[:id])
    @blogs = Blog.where(user_id: user.id)
  end

  def edit
    render file: "/public/404" unless current_user? && current_user.id == params[:id].to_i
    @blog = Blog.find_by(slug: params[:slug])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to blog_path(@blog.slug)
    else
      render :edit
    end
  end

  def destroy
    Blog.find(params[:id]).destroy
    redirect_to users_blogs_path(current_user)
  end

  private

    def blog_params
      params.require(:blog).permit(:title, :date, :content)
    end
end
