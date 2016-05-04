module Formatters
  def set_slug
    self.update_attribute(:slug, title.parameterize)
  end

  def format_time(time)
    time.strftime("%B %d, %Y")
  end

  def posted_on
    format_time(created_at)
  end
end
