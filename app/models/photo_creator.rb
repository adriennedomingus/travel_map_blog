class PhotoCreator
  def self.setup(photo, photo_params)
    update(photo)
    photo.set_location(photo_params)
  end

  def self.update(photo)
    photo.set_trip
    photo.set_slug
  end
end
