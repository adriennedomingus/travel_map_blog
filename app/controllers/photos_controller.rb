class PhotosController < ApplicationController

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.new(photo_params)
    if @photo.save
      if @photo.blog && @photo.blog.trip_id
        @photo.set_trip_and_color
      end
      gps_data = EXIFR::JPEG.new(photo_params[:image].tempfile).gps
      @photo.set_location(gps_data)
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
