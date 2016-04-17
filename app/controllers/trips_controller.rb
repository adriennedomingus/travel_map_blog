class TripsController < ApplicationController
  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      current_user.trips << @trip
      redirect_to users_trip_path(current_user, @trip.slug)
    else
      render :new
    end
  end

  def index
    @user = User.find(params[:id])
    @trips = @user.trips
  end

  def show
    @trip = Trip.find_by(slug: params[:slug])
  end

  def edit
    @trip = Trip.find_by(slug: params[:slug])
    render file: "/public/404" unless current_user? && current_user.id == @trip.user_id
  end

  def update
    @trip = Trip.find(params[:id])
    if @trip.update(trip_params)
      redirect_to trip_path(@trip.slug)
    else
      render :edit
    end
  end

  def destroy
    trip = Trip.find(params[:id])
    render file: "/public/404" unless current_user? && current_user.id == trip.user_id
    trip.blogs.each do |blog|
      blog.update_attribute(:trip_id, nil)
    end
    trip.destroy
    redirect_to users_trips_path(current_user)
  end

  private
    def trip_params
      params.require(:trip).permit(:name, :start_date, :end_date)
    end
end
