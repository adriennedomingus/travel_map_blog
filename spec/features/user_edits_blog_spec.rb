require 'rails_helper'

RSpec.feature "user edits a blog" do
  scenario "logged in user edits a blog" do
    user = create_user
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    _, b1 = create_trip_and_blog(user)

    visit blog_path(b1.slug)
    click_link "Edit"
    fill_in :blog_title, with: "new title"
    click_on "Update Blog"
    expect(page).to have_content("new title")
    expect(page).to have_content("Your blog has been updated!")
  end

  scenario "visitor cannot edit a blog" do
    user = create_user
    _, b1 = create_trip_and_blog(user)

    visit blog_path(b1.slug)
    expect(page).to_not have_content("Edit")
    visit edit_user_blog_path(user, b1.slug)
    expect(page).to have_content("The page you were looking for doesn't exist")
  end

  scenario "logged in user cannot edit another user's blog" do
    user = create_user
    other_user = User.create(provider: "twitter", uid: "123456", nickname: "adrienne", token: ENV['USER_TOKEN'], secret:  ENV['USER_SECRET'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(other_user)

    _, b1 = create_trip_and_blog(user)

    visit blog_path(b1.slug)
    expect(page).to_not have_content("Edit")
    visit edit_user_blog_path(user, b1.slug)
    expect(page).to have_content("The page you were looking for doesn't exist")
  end
end
