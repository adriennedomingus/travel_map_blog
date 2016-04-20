class PhotosController < ApplicationController

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.new(photo_params)
    if @photo.save
      if @photo.blog && @photo.blog.trip_id
        @photo.trip = @photo.blog.trip
      end
      gps_data = EXIFR::JPEG.new(photo_params[:image].tempfile).gps
      if gps_data
        @photo.update_attribute(:latitude, gps_data.latitude)
        @photo.update_attribute(:longitude, gps_data.longitude)
      end
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

  private

    def photo_params
      params.require(:photo).permit(:image, :title, :description, :blog_id, :trip_id)
    end
end
