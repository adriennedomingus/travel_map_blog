require 'rails_helper'

RSpec.describe Photos::SearchController, type: :controller do
  describe "POST search" do
    it "returns all photos matching search criteria" do
      VCR.use_cassette("photo.search") do
        user = create_user
        t1, b1 = create_trip_and_blog(user)
        create_photo(b1, user, t1)
        photo = Photo.create(title: "othertitle", description: "otherdescription", image:"http://s3.amazonaws.com/travel-map-blog/images/40/original/IMG_2013.JPG?1461168957", user_id: user.id, location: "Moscow")

        get :index, location: photo.location, radius: 50
        photos = JSON.parse(response.body)

        expect(photos["search"].count).to eq(1)
        expect(photos["search"].first["title"]).to eq(photo.title)
      end
    end
  end
end
