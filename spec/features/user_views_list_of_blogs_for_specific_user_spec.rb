require 'rails_helper'

RSpec.feature "user views index for specific user" do
  scenario "user  views index for specific user" do
    VCR.use_cassette("blog.lots") do
      user = create_user
      b1 = user.blogs.create(title: "title", date: "2016/03/19", content: "some content", slug: "title", latitude: -25, longitude: 131.0)
      b2 = user.blogs.create(title: "other title", date: "2016/03/25", content: "some more content", slug: "other-title", latitude: -25, longitude: 131.0)
      b3 = user.blogs.create(title: "third title", date: "2016/03/29", content: "final content", slug: "third-title", latitude: -25, longitude: 131.0)

      visit users_blogs_path(user.nickname)
      expect(page).to have_content(b1.title)
      expect(page).to have_content(b1.formatted_date)
      expect(page).to have_content(b2.formatted_date)
      expect(page).to have_content(b3.formatted_date)
    end
  end
end
