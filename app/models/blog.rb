class Blog < ActiveRecord::Base
  belongs_to :user

  def formatted_date
    date.strftime("%B %d, %Y")
  end

  def posted_on
    created_at.strftime("%B %d, %Y")
  end
end
