class AddLocationToBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :location, :string
  end
end
