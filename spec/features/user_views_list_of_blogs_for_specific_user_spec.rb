require 'rails_helper'

RSpec.feature "user views index for specific user" do
  scenario "user  views index for specific user" do
    user = User.create(provider: "twitter", uid: "1234", nickname: "adomingus", token: ENV['USER_TOKEN'], secret:  ENV['USER_SECRET'])
    b1 = user.blogs.create(title: "title", date: "2016/03/19", content: "some content")
    b2 = user.blogs.create(title: "other title", date: "2016/03/25", content: "some more content")
    b3 = user.blogs.create(title: "third title", date: "2016/03/29", content: "final content")

    visit users_blogs_path(user)
    expect(page).to have_content(b1.title)
    expect(page).to have_content(b1.formatted_date)
    expect(page).to have_content(b2.formatted_date)
    expect(page).to have_content(b3.formatted_date)
  end
end
