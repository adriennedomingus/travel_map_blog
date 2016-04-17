class BlogsController < ApplicationController
  def show
    @blog = Blog.find_by(slug: params[:slug])
  end

  def index
    @blogs = current_user.blogs
    render json: @blogs
  end
end
