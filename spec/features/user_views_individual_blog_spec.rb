require 'rails_helper'

RSpec.feature "user views specific blog" do
  scenario "user views specific blog" do
    user = User.create(provider: "twitter", uid: "1234", nickname: "adomingus", token: ENV['USER_TOKEN'], secret:  ENV['USER_SECRET'])
    b1 = user.blogs.create(title: "title", date: "2016/03/19", content: "some content")

    visit blog_path(b1)

    expect(page).to have_content(b1.title)
    expect(page).to have_content(b1.posted_on)
    expect(page).to have_content(b1.formatted_date)
  end
end
