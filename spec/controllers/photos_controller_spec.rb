require 'rails_helper'

RSpec.describe PhotosController, type: :controller do
  describe "GET index" do
    it "finds a user's photos" do
      VCR.use_cassette("photo#create_api") do
        user = create_user
        t1, b1 = create_trip_and_blog(user)
        photo = create_photo(b1, user, t1)

        get :index, nickname: user.nickname
        photos = JSON.parse(response.body)

        expect(photos["photos"].count).to eq(1)
        expect(photos["photos"].first["title"]).to eq(photo.title)
      end
    end
  end
end
