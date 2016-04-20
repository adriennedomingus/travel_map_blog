class AddColorToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :color, :string
  end
end
