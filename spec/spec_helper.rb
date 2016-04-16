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
