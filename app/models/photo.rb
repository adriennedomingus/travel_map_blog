class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :blog
  belongs_to :trip

  attr_accessor :image
  has_attached_file :image, :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:id/:style/:filename",
    styles: {
      favicon: '16x16>',
      square: '200x200#',
      medium: '300x300>'
    }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def set_location(gps_data)
    if gps_data
      self.update_attribute(:latitude, gps_data.latitude)
      self.update_attribute(:longitude, gps_data.longitude)
    elsif self.blog
      self.update_attribute(:latitude, blog.latitude)
      self.update_attribute(:longitude, blog.longitude)
    end
  end
end
