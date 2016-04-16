class Trip < ActiveRecord::Base
  has_many :blogs
  before_save :set_slug

  def set_slug
    self.slug = name.parameterize
  end
end
