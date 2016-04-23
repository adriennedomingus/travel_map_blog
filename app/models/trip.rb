class Trip < ActiveRecord::Base
  has_many :blogs
  has_many :photos
  belongs_to :user

  before_save :set_slug

  validates :name, presence: :true, uniqueness: :true
  validates_presence_of :start_date
  validates_presence_of :end_date
  validates_presence_of :color

  def set_slug
    self.slug = name.parameterize
  end

  def formatted_start_date
    format_time(start_date)
  end

  def formatted_end_date
    format_time(end_date)
  end

  def update_photos
    photos.each do |photo|
      photo.update_attribute(:color, self.color)
    end
  end

  private
    def format_time(time)
      time.strftime("%B %d, %Y")
    end
end
