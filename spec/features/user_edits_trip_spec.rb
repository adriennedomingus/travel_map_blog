require 'rails_helper'

RSpec.feature "user edits a trip" do
  scenario "logged in user edits a trip" do
    user = User.create(provider: "twitter", uid: "1234", nickname: "adomingus", token: ENV['USER_TOKEN'], secret:  ENV['USER_SECRET'])
    t1 = user.trips.create(name: "First trip", start_date: "2016/04/03", end_date: "2016/04/13", slug: "first-trip")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit users_trip_path(user, t1.slug)
    click_on "Edit"
    fill_in :trip_name, with: "new trip name"
    click_on "Update Trip"

    expect(page).to have_content("new trip name")
    expect(page).to have_content("Your trip has been updated!")
  end

  scenario "user cannot edit another users' trip" do
    user = User.create(provider: "twitter", uid: "1234", nickname: "adomingus", token: ENV['USER_TOKEN'], secret:  ENV['USER_SECRET'])
    other_user = User.create(provider: "twitter", uid: "123456", nickname: "adomingus2", token: ENV['USER_TOKEN'], secret:  ENV['USER_SECRET'])
    t1 = user.trips.create(name: "First trip", start_date: "2016/04/03", end_date: "2016/04/13", slug: "first-trip")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(other_user)

    visit edit_trip_path(t1.slug)

    expect(page).to have_content("The page you were looking for doesn't exist")
  end
end