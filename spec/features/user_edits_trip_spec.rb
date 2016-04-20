require 'rails_helper'

RSpec.feature "user edits a trip" do
  scenario "logged in user edits a trip" do
    VCR.use_cassette("blog.new") do
      user = create_user
      t1, _ = create_trip_and_blog(user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit users_trip_path(user, t1.slug)
      click_on "Edit"
      fill_in :trip_name, with: "new trip name"
      click_on "Update Trip"

      expect(page).to have_content("new trip name")
      expect(page).to have_content("Your trip has been updated!")
    end
  end

  scenario "logged in user must enter all information" do
    VCR.use_cassette("blog.new") do
      user = create_user
      t1, _ = create_trip_and_blog(user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit users_trip_path(user, t1.slug)
      click_on "Edit"
      fill_in :trip_name, with: ""
      click_on "Update Trip"

      expect(page).to have_content("Please enter all information")
    end
  end

  scenario "user cannot edit another users' trip" do
    VCR.use_cassette("blog.new") do
      user = create_user
      other_user = User.create(provider: "twitter", uid: "123456", nickname: "adomingus2", token: ENV['USER_TOKEN'], secret:  ENV['USER_SECRET'])
      t1, _ = create_trip_and_blog(user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(other_user)

      visit edit_trip_path(t1.slug)

      expect(page).to have_content("The page you were looking for doesn't exist")
    end
  end
end
