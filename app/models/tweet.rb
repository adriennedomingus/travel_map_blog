class Tweet
  def initialize(blog, current_user, path)
    TwitterService.new(current_user).post_tweet(path)
  end
end
