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
  end

  def update
    @trip = Trip.find(params[:id])
    if @trip.update(trip_params)
      redirect_to trip_path(@trip.slug)
    else
      render :edit
    end
  end

  private
    def trip_params
      params.require(:trip).permit(:name, :start_date, :end_date)
    end
end
