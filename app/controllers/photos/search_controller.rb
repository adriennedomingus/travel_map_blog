class Photos::SearchController < Blogs::BaseController
  def index
    @photos = Photo.near(params[:location], params[:radius].to_i)
    render json: @photos
  end
end
