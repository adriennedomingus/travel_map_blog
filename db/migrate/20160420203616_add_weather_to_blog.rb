class AddWeatherToBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :weather, :string
  end
end
