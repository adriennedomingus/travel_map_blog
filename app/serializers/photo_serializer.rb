class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :title, :slug
  has_one :blog
  has_one :trip
  has_one :user
end
