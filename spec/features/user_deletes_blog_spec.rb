require 'rails_helper'

RSpec.feature "user deletes a blog" do
  scenario "logged in user deletes their own blog" do
    VCR.use_cassette("blog.new") do
      user = create_user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      _, b1 = create_trip_and_blog(user)

      visit blog_path(b1.slug)
      click_on "Delete"
      expect(current_path).to eq(users_blogs_path(user.nickname))
      expect(page).to_not have_content("blog title")
    end
  end

  scenario "user deletes a blog with photos" do
    VCR.use_cassette("blog_photo.new") do
      user = create_user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      t1, b1 = create_trip_and_blog(user)
      create_photo(b1, user, t1)

      visit blog_path(b1.slug)
      within ".delete" do
        click_on "Delete"
      end
      expect(current_path).to eq(users_blogs_path(user.nickname))
      expect(page).to_not have_content("blog title")
    end
  end
end
