require 'simplecov'
SimpleCov.start

module SpecHelpers
  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      provider: 'twitter',
      uid: "12345",
      info: {
        nickname: "a_domingus"
            },
      credentials: {
        token: ENV['USER_TOKEN'],
        secret: ENV['USER_SECRET']
                    }
      })
  end

  def create_user
    User.create(provider: "twitter", uid: "1234", nickname: "adomingus", token: ENV['USER_TOKEN'], secret:  ENV['USER_SECRET'])
  end

  def create_trip_and_blog(user)
    twitter = double('twitter')
    allow(twitter).to receive(:post_tweet)
    allow(TwitterService).to receive(:new).and_return(twitter)

    t1 = user.trips.create(name: "First trip", start_date: "2016/04/03", end_date: "2016/04/13", slug: "first-trip", color: "#45adf3")
    b1 = t1.blogs.create(title: "Updated Title", date: "2016/03/17", content: "content", slug: "updated-title", location: "London, OH", user_id: user.id)
    BlogCreator.new(b1, user, "https://localhost:3000/blogs/#{b1.slug}").setup
    [t1, b1]
  end

  def create_second_trip_and_blog(user)
    twitter = double('twitter')
    allow(twitter).to receive(:post_tweet)
    allow(TwitterService).to receive(:new).and_return(twitter)

    t1 = user.trips.create(name: "Second trip", start_date: "2016/04/03", end_date: "2016/04/13", slug: "first-trip", color: "#45adf3")
    b1 = t1.blogs.create(title: "Second Title", date: "2016/03/19", content: "content", slug: "second-title", location: "Denver, CO")
    BlogCreator.new(b1, user, "https://localhost:3000/blogs/#{b1.slug}").setup
    [t1, b1]
  end

  def create_photo(blog, user, trip)
    blog.photos.create(title: "title", description: "description", image:"http://s3.amazonaws.com/travel-map-blog/images/40/original/IMG_2013.JPG?1461168957", user_id: user.id, trip_id: trip.id)
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.include SpecHelpers
end
