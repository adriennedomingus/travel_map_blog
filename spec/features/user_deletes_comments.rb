require 'rails_helper'

RSpec.feature "user deletes a blog comment" do
  scenario "logged in user deletes their own blog comment" do
    VCR.use_cassette("blog.new") do
      user = create_user
      _, b1 = create_trip_and_blog(user)

      logged_in_user = User.create(provider: "twitter", uid: "1234", nickname: "adrienne", token: ENV['USER_TOKEN'], secret:  ENV['USER_SECRET'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(logged_in_user)

      b1.comments.create(body: "a comment", user_id: logged_in_user.id)
      visit blog_path(b1.slug)
      expect(page).to have_content("a comment")
      within(".comments") do
        click_on "Delete"
      end
      expect(page).to have_content("Your comment has been deleted!")
      expect(page).to_not have_content("a comment")
    end
  end

  scenario "logged in user deletes their own trip comment" do
    VCR.use_cassette("blog.new") do
      user = create_user
      t1, _ = create_trip_and_blog(user)

      logged_in_user = User.create(provider: "twitter", uid: "1234", nickname: "adrienne", token: ENV['USER_TOKEN'], secret:  ENV['USER_SECRET'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(logged_in_user)

      t1.comments.create(body: "a comment", user_id: logged_in_user.id)
      visit users_trip_path(user.nickname, t1.slug)

      expect(page).to have_content("a comment")
      within(".comments") do
        click_on "Delete"
      end
      expect(page).to have_content("Your comment has been deleted!")
      expect(page).to_not have_content("a comment")
    end
  end

  scenario "logged in user deletes their own photo comment" do
    VCR.use_cassette("photo.new") do
      user = create_user
      t1, b1 = create_trip_and_blog(user)
      photo = create_photo(b1, user, t1)

      logged_in_user = User.create(provider: "twitter", uid: "1234", nickname: "adrienne", token: ENV['USER_TOKEN'], secret:  ENV['USER_SECRET'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(logged_in_user)

      photo.comments.create(body: "a comment", user_id: logged_in_user.id)
      visit user_photo_path(user.nickname, photo.slug)

      expect(page).to have_content("a comment")
      within(".comments") do
        click_on "Delete"
      end
      expect(page).to have_content("Your comment has been deleted!")
      expect(page).to_not have_content("a comment")
    end
  end
end
