require 'rails_helper'

RSpec.feature "user edits a trip" do
  scenario "logged in user edits a trip" do
    user = User.create(provider: "twitter", uid: "1234", nickname: "adomingus", token: ENV['USER_TOKEN'], secret:  ENV['USER_SECRET'])
    t1 = user.trips.create(name: "First trip", start_date: "2016/04/03", end_date: "2016/04/13", slug: "first-trip")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit edit_trip_path(t1.slug)
    fill_in :trip_name, with: "new trip name"
    click_on "Update Trip"

    expect(page).to have_content("new trip name")
  end

  scenario "user cannot edit another users' trip" do
  end
end
