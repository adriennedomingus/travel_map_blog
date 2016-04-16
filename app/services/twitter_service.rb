class TwitterService
  attr_reader :client

  def initialize(current_user)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["API_KEY"]
      config.consumer_secret     = ENV["API_SECRET"]
      config.access_token        = current_user.token
      config.access_token_secret = current_user.secret
    end
  end

  def post_tweet(blog_path)
    client.update("I just posted a new travel blog: #{blog_path}")
  end
end
