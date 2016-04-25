class TripsController < ApplicationController
  before_action :find_trip_by_slug, only: [:show, :edit]
  before_action :find_trip_by_id, only: [:update, :destroy]

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      current_user.trips << @trip
      flash[:success] = "Your trip has been created!"
      redirect_to users_trip_path(current_user.nickname, @trip.slug)
    else
      flash.now[:danger] = "Please enter all information"
      render :new
    end
  end

  def index
    @user = User.find_by(nickname: params[:nickname])
    @trips = @user.trips.order(start_date: :desc)
  end

  def edit
    render file: "/public/404" unless current_user && current_user == @trip.user
  end

  def update
    if @trip.update(trip_params)
      flash[:success] = "Your trip has been updated!"
      redirect_to trip_path(@trip.slug)
    else
      flash.now[:danger] = "Please enter all information"
      render :edit
    end
  end

  def destroy
    render file: "/public/404" unless current_user && current_user == @trip.user
    @trip.blogs.each do |blog|
      blog.update_attribute(:trip_id, nil)
    end
    @trip.destroy
    flash[:success] = "Your trip has been deleted!"
    redirect_to users_trips_path(current_user.nickname)
  end

  def color
    user = User.find_by(nickname: params[:nickname])
    @trips = user.trips
    render json: @trips
  end

  private
    def trip_params
      params.require(:trip).permit(:name, :start_date, :end_date, :color)
    end

    def find_trip_by_slug
      @trip = Trip.find_by(slug: params[:slug])
    end

    def find_trip_by_id
      @trip = Trip.find_by(id: params[:id])
    end
end
