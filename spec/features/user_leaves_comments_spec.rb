require 'rails_helper'

RSpec.feature "user edits a trip" do
  scenario "logged in user leaves a comment on a blog" do
    VCR.use_cassette("blog.new") do
      user = create_user
      _, b1 = create_trip_and_blog(user)

      logged_in_user = User.create(provider: "twitter", uid: "1234", nickname: "adrienne", token: ENV['USER_TOKEN'], secret:  ENV['USER_SECRET'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(logged_in_user)

      visit blog_path(b1.slug)
      fill_in :comment_body, with: "Leaving a comment"
      click_on "Leave Comment"

      expect(current_path).to eq(blog_path(b1.slug))
      expect(page).to have_content("Leaving a comment")
      expect(page).to have_content(logged_in_user.nickname)
    end
  end

  # scenario "user leaves a comment on a trip" do
  #   VCR.use_cassette("blog.new") do
  #     user = create_user
  #     t1, _ = create_trip_and_blog(user)
  #   end
  # end

  scenario "user must be logged in to create a comment" do
    VCR.use_cassette("blog.new") do
      user = create_user
      _, b1 = create_trip_and_blog(user)

      visit blog_path(b1.slug)
      fill_in :comment_body, with: "Leaving a comment"
      click_on "Leave Comment"

      expect(current_path).to eq(blog_path(b1.slug))
      expect(page).to_not have_content("Leaving a comment")
      expect(page).to have_content("You must be logged in to leave a comment. Please log in and try again.")
    end
  end

  scenario "user leaves a comment on a photo" do
    VCR.use_cassette("photo.edit") do
      user = create_user
      t1, b1 = create_trip_and_blog(user)
      photo = create_photo(b1, user, t1)

      logged_in_user = User.create(provider: "twitter", uid: "1234", nickname: "adrienne", token: ENV['USER_TOKEN'], secret:  ENV['USER_SECRET'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(logged_in_user)

      visit user_photo_path(user.nickname, photo.slug)
      fill_in :comment_body, with: "Leaving a comment"
      click_on "Leave Comment"

      expect(current_path).to eq(user_photo_path(user.nickname, photo.slug))
      expect(page).to have_content("Leaving a comment")
    end
  end
end
