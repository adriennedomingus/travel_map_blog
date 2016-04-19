require 'rails_helper'

RSpec.feature "user deletes a trip" do
  scenario "logged in user deletes a trip" do
    user = create_user
    t1, b1 = create_trip_and_blog(user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit users_trip_path(user.nickname, t1.slug)
    click_on "Delete"

    expect(page).to have_content("Your trip has been deleted!")
    expect(page).to_not have_content(t1.name)

    visit blog_path(b1.slug)
    expect(page).to_not have_content(t1.name)
  end

  scenario "user cannot delete another users' trip" do
    user = create_user
    other_user = User.create(provider: "twitter", uid: "123456", nickname: "adomingus2", token: ENV['USER_TOKEN'], secret:  ENV['USER_SECRET'])
    t1, _ = create_trip_and_blog(user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(other_user)

    visit users_trip_path(user.nickname, t1.slug)
    expect(page).to_not have_content("Delete")
  end
end
