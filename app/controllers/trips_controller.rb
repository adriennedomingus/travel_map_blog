class TripsController < ApplicationController
  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      redirect_to users_trip_path(current_user, @trip.slug)
    else
      render :new
    end
  end

  def show
    @trip = Trip.find_by(slug: params[:slug])
  end

  private
    def trip_params
      params.require(:trip).permit(:name, :start_date, :end_date)
    end
end
