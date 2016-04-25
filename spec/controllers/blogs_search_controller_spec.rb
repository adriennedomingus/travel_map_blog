require 'rails_helper'

RSpec.describe Blogs::SearchController, type: :controller do
  describe "POST search" do
    it "returns all blogs matching search criteria" do
      VCR.use_cassette("blog.search") do
        user = create_user
        _, b1 = create_trip_and_blog(user)
        create_second_trip_and_blog(user)
        get :index, location: b1.location, radius: 50
        blogs = JSON.parse(response.body)

        expect(blogs["search"].count).to eq(1)
        expect(blogs["search"].first["title"]).to eq(b1.title)
      end
    end
  end
end
