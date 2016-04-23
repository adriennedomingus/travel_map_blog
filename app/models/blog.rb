class Blog < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip
  has_many :photos

  validates :title, presence: :true
  validates :title, uniqueness: :true
  validates :date, presence: :true
  validates :content, presence: :true
  validates :location, presence: :true

  geocoded_by :location
  after_validation :geocode

  def formatted_date
    format_time(date)
  end

  def posted_on
    format_time(created_at)
  end

  def set_slug
    self.update_attribute(:slug, title.parameterize)
  end

  def set_color
    if trip
      self.update_attribute(:color, trip.color)
    end
  end

  def set_weather
    self.weather = Weather.description(self)
  end

  def get_image
    if self.weather
      term = self.weather.split(" ")[-1]
    else
      term = "travel"
    end
    UnsplashService.new.random_by_search(term)
  end

  private

    def format_time(time)
      time.strftime("%B %d, %Y")
    end
end
