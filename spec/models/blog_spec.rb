require 'rails_helper'

RSpec.describe Blog, type: :model do
  it { should belong_to :user }
  it { should belong_to :trip }
  it { should validate_presence_of :title }
  it { should validate_presence_of :date }
  it { should validate_presence_of :content }
  it { should validate_presence_of :location }

  it "returns an image based on weather" do
    VCR.use_cassette("blog#get_image") do
      user = create_user
      _, b1 = create_trip_and_blog(user)

      image = b1.get_image
      expect(image.class).to eq(String)
    end
  end
end
