class AddLatitudeAndLongitudeToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :latitude, :decimal
    add_column :photos, :longitude, :decimal
  end
end
