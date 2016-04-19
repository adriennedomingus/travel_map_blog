class UnsplashService
  def initialize
    Unsplash.configure do |config|
      config.application_id     = ENV["UNSPLASH_ID"]
      config.application_secret = ENV["UNSPLASH_SECRET"]
    end
  end

  def random_by_search(term)
    photos = Unsplash::Photo.search(term)
    count = photos.count
    num_photo = Random.rand(0..count - 1)
    photos[num_photo].urls["full"]
  end
end
