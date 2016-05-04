require 'rails_helper'

RSpec.feature do
  scenario "user views photo index" do
    VCR.use_cassette("photo#create-twice") do
      user = create_user
      t1, b1 = create_trip_and_blog(user)
      photo1 = create_photo(b1, user, t1)
      photo2 = create_photo(b1, user, t1)

      visit user_photos_path(user.nickname)

      expect(page).to have_content(photo1.title)
      expect(page).to have_content(photo2.title)
      expect(page).to have_content(photo1.description)
      expect(page).to have_content(photo2.description)
      expect(page).to have_content(photo1.blog.title)
      expect(page).to have_content(photo2.blog.title)
      expect(page).to have_content(photo1.trip.name)
      expect(page).to have_content(photo2.trip.name)
      expect(page).to have_css("img[alt='Img 2013']")

    end
  end

  scenario "user views individual photo" do
    VCR.use_cassette("photo#create") do
      user = create_user
      t1, b1 = create_trip_and_blog(user)
      photo = create_photo(b1, user, t1)

      visit user_photo_path(user.nickname, photo.slug)

      expect(page).to have_content(photo.title)
      expect(page).to have_content(photo.description)
      expect(page).to have_content(photo.blog.title)
      expect(page).to have_content(photo.trip.name)
      expect(page).to have_css("img[alt='Img 2013']")
    end
  end
end
