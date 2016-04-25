require 'rails_helper'

RSpec.feature "user views specific blog" do
  scenario "user views specific blog" do
    VCR.use_cassette('photo#create') do
      user = create_user
      t1, b1 = create_trip_and_blog(user)
      create_photo(b1, user, t1)

      visit blog_path(b1.slug)
      expect(page).to have_content(b1.title)
      expect(page).to have_content(b1.posted_on)
      expect(page).to have_content(b1.formatted_date)
      expect(page).to have_content(user.nickname)
      expect(page).to have_css("img[alt='Img 2013']")
    end
  end
end
