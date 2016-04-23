class BlogsController < ApplicationController
  before_action :find_blog, only: [:show, :weather]

  def index
    user = User.find_by(nickname: params[:nickname])
    @blogs = user.blogs
    render json: @blogs
  end

  def weather
    if @blog
      @image = @blog.get_image
      render json: {image: @image }
    else
      render json: {image: nil}
    end
  end

  private
  def find_blog
    @blog = Blog.find_by(slug: params[:slug])
  end
end
