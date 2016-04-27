require 'rails_helper'

RSpec.feature "user views map", :js => true do
  scenario "it has markers" do
    VCR.use_cassette("test feature js spec") do
      user = create_user
      _, blog = create_trip_and_blog(user)

      visit user_path(user.nickname)

      marker = page.all(:xpath, "//*[@id="map"]/div[2]/div[4]/div")
      require "pry"
      binding.pry
    end
  end
end
