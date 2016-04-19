class AddColorToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :color, :string
  end
end
