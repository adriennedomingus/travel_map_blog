class ChangeLatitudeAndLongitudeToDecimals < ActiveRecord::Migration
  def change
    change_column :blogs, :latitude, :decimal
    change_column :blogs, :longitude, :decimal
  end
end
