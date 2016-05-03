class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  def posted_on
    format_time(created_at)
  end

  private

    def format_time(time)
      time.strftime("%B %d, %Y")
    end
end
