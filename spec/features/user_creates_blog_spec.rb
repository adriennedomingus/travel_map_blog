require 'rails_helper'

RSpec.feature "user writes a blog" do
  scenario "logged in user creates a blog" do
    user = User.create(provider: "twitter", uid: "1234", nickname: "adomingus", token: ENV['USER_TOKEN'], secret:  ENV['USER_SECRET'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit new_user_blog_path
    fill_in :blog_title, with: "Title"
    fill_in :blog_date, with: "2015/03/17"
    fill_in :blog_content, with: "blog content"
    click_on "Post Blog"

    expect(page).to have_content("Title")
    expect(page).to have_content("March 17, 2015")
    expect(page).to have_content("blog content")
  end

  scenario "visitor cannot create a blog" do
    visit new_user_blog_path
    expect(page).to have_content("The page you were looking for doesn't exist")
  end
end
