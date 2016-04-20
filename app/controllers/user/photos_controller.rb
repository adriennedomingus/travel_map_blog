class User::PhotosController < User::BaseController
  def index
    user = User.find_by(nickname: params[:nickname])
    @photos = user.photos.order(image_updated_at: :desc)
  end
end
