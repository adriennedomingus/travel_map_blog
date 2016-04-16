require 'rails_helper'

RSpec.feature "user deletes a blog" do
  scenario "logged in user deletes their own blog" do
    user = User.create(provider: "twitter", uid: "1234", nickname: "adomingus", token: ENV['USER_TOKEN'], secret:  ENV['USER_SECRET'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    blog = user.blogs.create(title: "blog title", date: "2016/03/20", content: "content", slug: "title")

    visit blog_path(blog.slug)
    click_on "Delete"
    expect(current_path).to eq(users_blogs_path(user))
    expect(page).to_not have_content("blog_title")
  end
end
