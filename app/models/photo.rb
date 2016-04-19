class Photo < ActiveRecord::Base
  belongs_to :user
  attr_accessor :image
  has_attached_file :image, :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:id/:style/:filename",
    styles: {
      favicon: '16x16>',
      square: '200x200#',
      medium: '300x300>'
    }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
