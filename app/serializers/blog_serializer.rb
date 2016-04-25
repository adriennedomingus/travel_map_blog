class BlogSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :title, :slug
  has_one :trip
end
