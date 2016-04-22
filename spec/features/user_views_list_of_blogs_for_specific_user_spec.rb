require 'rails_helper'

RSpec.feature "user views index for specific user" do
  scenario "user  views index for specific user" do
    VCR.use_cassette("blog.lots") do
      user = create_user

      twitter = double('twitter')
      allow(twitter).to receive(:post_tweet)
      allow(TwitterService).to receive(:new).and_return(twitter)
      
      b1 = user.blogs.create(title: "title", date: "2016/03/19", content: "some content", slug: "title", location: "Denver, CO")
      b2 = user.blogs.create(title: "other title", date: "2016/03/25", content: "some more content", slug: "other-title", location: "Denver, CO")
      b3 = user.blogs.create(title: "third title", date: "2016/03/29", content: "final content", slug: "third-title", location: "Denver, CO")
      BlogCreator.new(b1, user, blog_url(b1.slug)).setup
      BlogCreator.new(b2, user, blog_url(b1.slug)).setup
      BlogCreator.new(b3, user, blog_url(b1.slug)).setup

      visit users_blogs_path(user.nickname)
      expect(page).to have_content(b1.title)
      expect(page).to have_content(b1.formatted_date)
      expect(page).to have_content(b2.formatted_date)
      expect(page).to have_content(b3.formatted_date)
    end
  end
end
