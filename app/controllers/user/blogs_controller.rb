class User::BlogsController < User::BaseController
  before_action :require_user, except: [:index]
  before_action :find_blog, only: [:update, :destroy]

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      BlogCreator.new(@blog, current_user).setup
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
    render file: "/public/404" unless current_user && current_user.nickname == params[:nickname]
    @blog = Blog.find_by(slug: params[:slug])
  end

  def update
    if @blog.update(blog_params)
      BlogCreator.new(@blog, current_user).update
      flash[:success] = "Your blog has been updated!"
      redirect_to blog_path(@blog.slug)
    else
      flash.now[:danger] = "Please enter all information"
      render :edit
    end
  end

  def destroy
    @blog.photos.each do |photo|
      photo.update_attribute(:blog_id, nil)
    end
    @blog.destroy
    flash[:success] = "Your blog has been deleted!"
    redirect_to users_blogs_path(current_user.nickname)
  end

  private
    def blog_params
      params.require(:blog).permit(:title, :date, :content, :trip_id, :location)
    end

    def find_blog
      @blog = Blog.find(params[:id])
    end
end
