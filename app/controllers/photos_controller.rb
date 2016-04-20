class PhotosController < ApplicationController

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.new(photo_params)
    if @photo.save
      @photo.set_location(photo_params)
      flash[:success] = "Your photo has been uploaded!"
      redirect_to photo_path(@photo)
    else
      flash.now[:danger] = "Please enter all information"
      render :new
    end
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def index
    user = User.find_by(nickname: params[:nickname])
    @photos = user.photos
    render json: @photos
  end

  private

    def photo_params
      params.require(:photo).permit(:image, :title, :description, :blog_id, :trip_id)
    end
end
