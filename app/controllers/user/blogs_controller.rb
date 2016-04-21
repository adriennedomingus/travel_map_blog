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
      flash[:success] = "Your blog has been posted!"
      redirect_to blog_path(@blog.slug)
    else
      flash.now[:danger] = "Please enter all information"
      render :new
    end
  end

  def index
    user = User.find_by(nickname: params[:nickname])
    @blogs = Blog.where(user_id: user.id).order(date: :desc)
  end

  def edit
    render file: "/public/404" unless current_user? && current_user.nickname == params[:nickname]
    @blog = Blog.find_by(slug: params[:slug])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      flash[:success] = "Your blog has been updated!"
      redirect_to blog_path(@blog.slug)
    else
      flash.now[:danger] = "Please enter all information"
      render :edit
    end
  end

  def destroy
    Blog.find(params[:id]).destroy
    flash[:success] = "Your blog has been deleted!"
    redirect_to users_blogs_path(current_user.nickname)
  end

  private

    def blog_params
      params.require(:blog).permit(:title, :date, :content, :trip_id, :latitude, :longitude)
    end
end
