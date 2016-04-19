require 'rails_helper'

RSpec.feature "user views a trip" do
  scenario "user views trips index" do
    user = User.create(provider: "twitter", uid: "1234", nickname: "adomingus", token: ENV['USER_TOKEN'], secret:  ENV['USER_SECRET'])
    t1 = user.trips.create(name: "First trip", start_date: "2016/04/03", end_date: "2016/04/13", slug: "first-trip", color: "45adf3")
    t2 = user.trips.create(name: "Second trip", start_date: "2016/04/17", end_date: "2016/04/27", slug: "first-trip", color: "45adf3")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit users_trips_path(user.nickname)

    expect(page).to have_content(t1.name)
    expect(page).to have_content(t1.formatted_start_date)
    expect(page).to have_content(t1.formatted_end_date)
    expect(page).to have_content(t2.name)
    expect(page).to have_content(t2.formatted_start_date)
    expect(page).to have_content(t2.formatted_end_date)
  end

  scenario "user views a specific trip" do
    user = User.create(provider: "twitter", uid: "1234", nickname: "adomingus", token: ENV['USER_TOKEN'], secret:  ENV['USER_SECRET'])

    t1 = user.trips.create(name: "First trip", start_date: "2016/04/03", end_date: "2016/04/13", slug: "first-trip", color: "45adf3")
    user.trips.create(name: "Second trip", start_date: "2016/04/17", end_date: "2016/04/27", slug: "first-trip", color: "45adf3")

    b1 = t1.blogs.create(title: "blog title", date: "2016/03/20", content: "content", slug: "title", latitude: -40, longitude: 104)
    b2 = t1.blogs.create(title: "blog two title", date: "2016/03/20", content: "content", slug: "title", latitude: -40, longitude: 104)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit users_trips_path(user.nickname)
    click_on t1.name

    expect(page).to have_content(b1.title)
    expect(page).to have_content(b1.formatted_date)
    expect(page).to have_content(b2.title)
    expect(page).to have_content(b2.formatted_date)
  end
end
