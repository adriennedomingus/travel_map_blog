class Trip < ActiveRecord::Base
  has_many :blogs
  belongs_to :user
  before_save :set_slug

  def set_slug
    self.slug = name.parameterize
  end

  def formatted_start_date
    start_date.strftime("%B %d, %Y")
  end

  def formatted_end_date
    end_date.strftime("%B %d, %Y")
  end
end
