require 'rails_helper'

RSpec.describe UnsplashService do
  context "returns a random photo by search term" do
    it "returns a string URL" do
      VCR.use_cassette("unsplash#random") do
        service = UnsplashService.new
        expect(service.random_by_search("rain").class).to eq(String)
      end
    end
  end
end
