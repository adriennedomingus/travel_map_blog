require 'rails_helper'

RSpec.describe BlogsController, type: :controller do
  describe "GET index" do
    it "finds a user's blogs" do
      VCR.use_cassette("blog.new") do
        user = create_user
        _, b1 = create_trip_and_blog(user)
        get :index, nickname: user.nickname
        blogs = JSON.parse(response.body)

        expect(blogs.count).to eq(1)
        expect(blogs.first["title"]).to eq(b1.title)
      end
    end
  end

  describe "GET weather" do
    it "gets the image associated with a blog's weather" do
      VCR.use_cassette("blog#weather") do
        user = create_user
        _, b1 = create_trip_and_blog(user)
        get :weather, slug: b1.slug
        image = JSON.parse(response.body)

        (image["image"]).should match(/https:\/\/images.unsplash.com\/.+/)
      end
    end
  end
end
