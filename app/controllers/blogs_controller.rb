class BlogsController < ApplicationController
  def show
    @blog = Blog.find_by(slug: params[:slug])
  end
end
