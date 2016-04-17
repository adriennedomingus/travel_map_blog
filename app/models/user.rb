class User < ActiveRecord::Base
  has_many :blogs
  has_many :trips

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.nickname = auth["info"]["nickname"]
      user.token = auth["credentials"]["token"]
      user.secret = auth["credentials"]["secret"]
    end
  end
end
