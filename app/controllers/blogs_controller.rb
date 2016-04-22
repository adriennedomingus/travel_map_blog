class BlogsController < ApplicationController
  def show
    @blog = Blog.find_by(slug: params[:slug])
  end

  def index
    user = User.find_by(nickname: params[:nickname])
    @blogs = user.blogs
    render json: @blogs
  end

  def weather
      blog = Blog.find_by(slug: params[:slug])
    if blog
      @image = blog.get_image
      render json: {image: @image }
    else
      render json: {image: nil}
    end
  end
end
