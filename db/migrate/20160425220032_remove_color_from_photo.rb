class RemoveColorFromPhoto < ActiveRecord::Migration
  def change
    remove_column :photos, :color
  end
end
