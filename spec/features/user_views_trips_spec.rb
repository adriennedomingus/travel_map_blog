require 'rails_helper'

RSpec.feature "user views a trip" do
  scenario "user views trips index" do
      user = create_user
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
    VCR.use_cassette('integration#create') do
      user = create_user
      t1, b1 = create_trip_and_blog(user)
      create_second_trip_and_blog(user)
      create_photo(b1, user, t1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit users_trips_path(user.nickname)
      click_on t1.name

      expect(page).to have_content(b1.title)
      expect(page).to have_content(b1.formatted_date)
      expect(page).to have_css("img[alt='Img 2013']")
    end
  end
end
