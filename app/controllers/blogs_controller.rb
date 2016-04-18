class BlogsController < ApplicationController
  def show
    @blog = Blog.find_by(slug: params[:slug])
  end

  def index
    user = User.find_by(nickname: params[:nickname])
    @blogs = user.blogs
    render json: @blogs
  end
end
