class Comment < ActiveRecord::Base
  include Formatters

  belongs_to :user
  belongs_to :commentable, polymorphic: true
end
