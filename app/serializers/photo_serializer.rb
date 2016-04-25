class PhotoSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :title
  has_one :blog
  has_one :trip
end
