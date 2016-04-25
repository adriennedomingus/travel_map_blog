class RemoveColorFrom < ActiveRecord::Migration
  def change
    remove_column :blogs, :color
  end
end
