class Blog < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip
  has_many :photos

  before_save :set_slug
  before_save :set_color
  before_save :set_weather

  validates :title, presence: :true
  validates :title, uniqueness: :true
  validates :date, presence: :true
  validates :content, presence: :true
  validates :location, presence: :true

  geocoded_by :location
  after_validation :geocode

  def formatted_date
    date.strftime("%B %d, %Y")
  end

  def posted_on
    created_at.strftime("%B %d, %Y")
  end

  def set_slug
    self.slug = title.parameterize
  end

  def set_color
    if trip
      self.color = trip.color
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
end
