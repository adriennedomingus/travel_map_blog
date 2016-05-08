class Blog < ActiveRecord::Base
  include Formatters

  belongs_to :user
  belongs_to :trip
  has_many :photos
  has_many :comments, as: :commentable

  validates :title, presence: :true
  validates :date, presence: :true
  validates :content, presence: :true
  validates :location, presence: :true
  validates :title, uniqueness: { scope: :user_id,
    message: "should be unique" }

  geocoded_by :location
  after_validation :geocode

  def formatted_date
    format_time(date)
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
