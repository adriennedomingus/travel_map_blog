require 'rails_helper'

RSpec.describe TripsController, type: :controller do
  describe "GET colors" do
    it "finds a user's trips" do
      VCR.use_cassette("trips#index") do
        user = create_user
        t1, _ = create_trip_and_blog(user)
        create_second_trip_and_blog(user)

        get :color, nickname: user.nickname

        trips = JSON.parse(response.body)
        expect(trips.count).to eq(2)
        expect(trips.first["name"]).to eq(t1.name)
      end
    end
  end
end
