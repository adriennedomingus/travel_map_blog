require 'rails_helper'

RSpec.feature "user edits a blog" do
  scenario "logged in user edits a blog" do
    user = User.create(provider: "twitter", uid: "1234", nickname: "adomingus", token: ENV['USER_TOKEN'], secret:  ENV['USER_SECRET'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    blog = user.blogs.create(title: "title", date: "2016/03/20", content: "content", slug: "title")

    visit blog_path(blog.slug)
    click_link "Edit"
    fill_in :blog_title, with: "new title"
    click_on "Update Blog"
    expect(page).to have_content("new title")
  end

  scenario "visitor cannot edit a blog" do
    user = User.create(provider: "twitter", uid: "1234", nickname: "adomingus", token: ENV['USER_TOKEN'], secret:  ENV['USER_SECRET'])
    blog = user.blogs.create(title: "title", date: "2016/03/20", content: "content", slug: "title")

    visit blog_path(blog.slug)
    expect(page).to_not have_content("Edit")
    visit edit_user_blog_path(user, blog.slug)
    expect(page).to have_content("The page you were looking for doesn't exist")
  end

  scenario "logged in user cannot edit another user's blog" do
    user = User.create(provider: "twitter", uid: "1234", nickname: "adomingus", token: ENV['USER_TOKEN'], secret:  ENV['USER_SECRET'])
    other_user = User.create(provider: "twitter", uid: "123456", nickname: "adrienne", token: ENV['USER_TOKEN'], secret:  ENV['USER_SECRET'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(other_user)

    blog = user.blogs.create(title: "title", date: "2016/03/20", content: "content", slug: "title")

    visit blog_path(blog.slug)
    expect(page).to_not have_content("Edit")
    visit edit_user_blog_path(user, blog.slug)
    expect(page).to have_content("The page you were looking for doesn't exist")
  end
end
