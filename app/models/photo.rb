class Photo < ActiveRecord::Base
  include Formatters

  belongs_to :user
  belongs_to :blog
  belongs_to :trip
  has_many :comments, as: :commentable

  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :image
  validates :title, uniqueness: { scope: :user_id,
    message: "should be unique" }

  geocoded_by :location
  after_validation :geocode

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

  def set_trip
    if self.blog && self.blog.trip_id
      self.update_attribute(:trip, blog.trip)
    end
  end
end
