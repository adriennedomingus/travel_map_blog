require 'rails_helper'

RSpec.feature "user deletes a blog" do
  scenario "logged in user deletes their own blog" do
    user = create_user
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    _, b1 = create_trip_and_blog(user)

    visit blog_path(b1.slug)
    click_on "Delete"
    expect(current_path).to eq(users_blogs_path(user.nickname))
    expect(page).to_not have_content("blog title")
  end
end
