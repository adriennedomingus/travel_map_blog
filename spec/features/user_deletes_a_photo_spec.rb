require 'rails_helper'

RSpec.feature "user deletes a photo" do
  scenario "user deletes a photo" do
    VCR.use_cassette("photo.edit") do
      user = create_user
      trip, blog = create_trip_and_blog(user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      photo = create_photo(blog, user, trip)

      visit photo_path(photo)
      click_on "Delete"

      expect(page).to_not have_content("Photo title")
    end
  end
end
