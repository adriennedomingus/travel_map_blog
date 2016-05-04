class Trip < ActiveRecord::Base
  include Formatters
  
  has_many :blogs
  has_many :photos
  belongs_to :user
  has_many :comments, as: :commentable

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
end
