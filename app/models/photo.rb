class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :blog
  belongs_to :trip

  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :image

  attr_accessor :image
  has_attached_file :image,
    path: ":rails_root/public/system/:attachment/:id/:style/:filename",
    url: "/system/:attachment/:id/:style/:filename",
    styles: {
      large: '500x500>'
    }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def set_location(photo_params)
    begin
      gps_data = EXIFR::JPEG.new(photo_params[:image].tempfile).gps
      if gps_data
        self.update_attribute(:latitude, gps_data.latitude)
        self.update_attribute(:longitude, gps_data.longitude)
      end
    rescue
      if self.blog
        self.update_attribute(:latitude, blog.latitude)
        self.update_attribute(:longitude, blog.longitude)
      end
    end
  end

  def set_trip_and_color
    if self.blog && self.blog.trip_id
      self.update_attribute(:trip, blog.trip)
      self.update_attribute(:color, blog.trip.color)
    elsif self.trip
      self.update_attribute(:color, trip.color)
    end
  end
end
