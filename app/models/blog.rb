class Blog < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip
  before_save :set_slug

  def formatted_date
    date.strftime("%B %d, %Y")
  end

  def posted_on
    created_at.strftime("%B %d, %Y")
  end

  def set_slug
    self.slug = title.parameterize
  end
end
