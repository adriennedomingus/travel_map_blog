class AddLatLongToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :latitude, :integer
    add_column :blogs, :longitude, :integer
  end
end
