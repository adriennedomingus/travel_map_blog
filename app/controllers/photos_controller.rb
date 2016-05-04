class PhotosController < ApplicationController
  before_action :find_photo, only: [:edit, :update]

  def new
    @photo = Photo.new
  end

  def create
    @photo = current_user.photos.new(photo_params)
    if @photo.save
      PhotoCreator.setup(@photo, photo_params)
      flash[:success] = "Your photo has been uploaded!"
      redirect_to user_photo_path(current_user.nickname, @photo.slug)
    else
      flash.now[:danger] = "Please enter all information"
      render :new
    end
  end

  def index
    user = User.find_by(nickname: params[:nickname])
    @photos = user.photos

    render json: @photos
  end

  def update
    if @photo.update(photo_params)
      PhotoCreator.update(@photo)
      flash[:success] = "Your photo has been updated!"
      redirect_to user_photos_path(current_user.nickname)
    else
      flash[:danger] = "Please enter all information"
      render :edit
    end
  end

  def destroy
    Photo.find(params[:id]).destroy
    flash[:success] = "Your photo has been deleted!"
    redirect_to user_photos_path(current_user.nickname)
  end

  private

    def photo_params
      params.require(:photo).permit(:image, :title, :description, :blog_id, :trip_id, :location)
    end

    def find_photo
      @photo = Photo.find(params[:id])
    end
end
