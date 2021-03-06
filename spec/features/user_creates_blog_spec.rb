require 'rails_helper'

RSpec.feature "user writes a blog" do
  scenario "logged in user creates a blog" do
    VCR.use_cassette("blog.hand_create") do
      stub_omniauth
      
      twitter = double('twitter')
      allow(twitter).to receive(:post_tweet)
      allow(TwitterService).to receive(:new).and_return(twitter)

      visit "/"
      click_link "Sign in with Twitter"
      user = User.last
      user.trips.create(name: "First trip", start_date: "2016/04/03", end_date: "2016/04/13", slug: "first-trip", color: "45adf3")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit new_user_blog_path
      fill_in :blog_title, with: "Title"
      fill_in :blog_date, with: "2015/03/17"
      fill_in :blog_content, with: "blog content"
      fill_in :blog_location, with: "-45.234"
      select "First trip", from: "blog[trip_id]"
      click_on "Post Blog"
      expect(page).to have_content("Title")
      expect(page).to have_content("First trip")
      expect(page).to have_content("March 17, 2015")
      expect(page).to have_content("blog content")
      expect(page).to have_content("Your blog has been posted!")
    end
  end

  scenario "user must enter all attributes" do
    user = create_user
    user.trips.create(name: "First trip", start_date: "2016/04/03", end_date: "2016/04/13", slug: "first-trip", color: "45adf3")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit new_user_blog_path
    fill_in :blog_date, with: "2015/03/17"
    fill_in :blog_content, with: "blog content"
    select "First trip", from: "blog[trip_id]"
    click_on "Post Blog"

    expect(page).to have_content("Please enter all information")
  end

  scenario "visitor cannot create a blog" do
    visit new_user_blog_path
    expect(page).to have_content("The page you were looking for doesn't exist")
  end
end
