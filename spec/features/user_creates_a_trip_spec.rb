require 'rails_helper'

RSpec.feature "user creates a trip" do
  scenario "logged in user creates a trip" do
    user = User.create(provider: "twitter", uid: "1234", nickname: "adomingus", token: ENV['USER_TOKEN'], secret:  ENV['USER_SECRET'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit new_trip_path
    fill_in :trip_name, with: "trip name"
    fill_in :trip_start_date, with: "2016/03/14"
    fill_in :trip_end_date, with: "2016/03/19"
    click_on "Create Trip"
    expect(page).to have_content("trip name")
    expect(page).to have_content("Your trip has been created!")
  end

  scenario "user must enter all information" do
    user = User.create(provider: "twitter", uid: "1234", nickname: "adomingus", token: ENV['USER_TOKEN'], secret:  ENV['USER_SECRET'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit new_trip_path
    fill_in :trip_name, with: "trip name"
    fill_in :trip_end_date, with: "2016/03/19"
    click_on "Create Trip"
    expect(page).to have_content("Please enter all information")
  end
end
