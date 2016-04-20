require 'rails_helper'

RSpec.describe Photo, type: :model do
  it { should belong_to :user }
  it { should belong_to :trip }
  it { should belong_to :blog }
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
  it { should validate_presence_of :image }

  it "sets the photos location with blog location" do
    VCR.use_cassette("photo#create") do
      user = create_user
      _, b1 = create_trip_and_blog(user)
      photo = Photo.create(title: "title", description: "description", image:"http://s3.amazonaws.com/travel-map-blog/images/40/original/IMG_2013.JPG?1461168957", user_id: user.id, blog_id: b1.id )

      photo_params = {}
      photo.set_location(photo_params)

      expect(photo.latitude).to eq(b1.latitude)
      expect(photo.longitude).to eq(b1.longitude)
    end
  end

  it "sets the photos trip and color from blog association" do
    VCR.use_cassette("photo#create") do
      user = create_user
      t1, b1 = create_trip_and_blog(user)
      photo = Photo.create(title: "title", description: "description", image:"http://s3.amazonaws.com/travel-map-blog/images/40/original/IMG_2013.JPG?1461168957", user_id: user.id, blog_id: b1.id )
      expect(photo.trip).to eq(t1)
      expect(photo.color).to eq(t1.color)
    end
  end

  it "sets photo color from trip association" do
    VCR.use_cassette("photo#create") do
      user = create_user
      t1, _ = create_trip_and_blog(user)
      photo = Photo.create(title: "title", description: "description", image:"http://s3.amazonaws.com/travel-map-blog/images/40/original/IMG_2013.JPG?1461168957", user_id: user.id, trip_id: t1.id )
      expect(photo.color).to eq(t1.color)
    end
  end
end
