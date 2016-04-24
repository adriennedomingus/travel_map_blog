class Blogs::SearchController < Blogs::BaseController
  def index
    @blogs = Blog.near(params[:location], params[:radius].to_i)
    render json: @blogs
  end
end
