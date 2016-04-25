require 'rails_helper'

RSpec.feature "user edits a photo" do
  scenario "user edits a photo" do
    VCR.use_cassette("photo.edit") do
      user = create_user
      trip, blog = create_trip_and_blog(user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      photo = create_photo(blog, user, trip)

      visit edit_photo_path(photo)
      fill_in :photo_title, with: "Updated photo title"
      fill_in :photo_description, with: "Photo description"
      click_on "Update Photo"

      expect(current_path).to eq(user_photos_path(user.nickname))
      expect(page).to have_content("Updated photo title")
    end
  end

  scenario "user must include all information" do
    VCR.use_cassette("photo.edit") do
      user = create_user
      trip, blog = create_trip_and_blog(user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      photo = create_photo(blog, user, trip)

      visit edit_photo_path(photo)
      fill_in :photo_title, with: ""
      fill_in :photo_description, with: "Photo description"
      click_on "Update Photo"

      expect(page).to have_content("Please enter all information")
    end
  end
end
