require 'rails_helper'

RSpec.describe Weather, type: :model do
  it "pulls a description" do
    VCR.use_cassette("weather.new") do
      twitter = double('twitter')
      allow(twitter).to receive(:post_tweet)
      allow(TwitterService).to receive(:new).and_return(twitter)

      user = create_user
      blog = user.blogs.create(title: "Updated Title", date: "2016/03/17", content: "content", slug: "updated-title", latitude: -25.0, longitude: 131.0)
      BlogCreator.new(blog, user, "https://localhost:3000/blogs/#{blog.slug}").setup
      response = Weather.description(blog)

      expect(response).to eq("Sunny")
    end
  end

  it "returns a weather object" do
    VCR.use_cassette("weather.all") do
      twitter = double('twitter')
      allow(twitter).to receive(:post_tweet)
      allow(TwitterService).to receive(:new).and_return(twitter)
      
      user = create_user
      blog = user.blogs.create(title: "Updated Title", date: "2016/03/17", content: "content", slug: "updated-title", latitude: -25.0, longitude: 131.0)
      BlogCreator.new(blog, user, "https://localhost:3000/blogs/#{blog.slug}").setup
      response = Weather.all_data(blog)["data"]["weather"].first
      expect(response["hourly"].count).to eq(8)
    end
  end
end
