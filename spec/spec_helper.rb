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
    t1 = user.trips.create(name: "First trip", start_date: "2016/04/03", end_date: "2016/04/13", slug: "first-trip", color: "45adf3")
    b1 = t1.blogs.create(title: "blog title", date: "2016/03/20", content: "content", slug: "title", latitude: -40, longitude: 104, user_id: user.id)
    [t1, b1]
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
