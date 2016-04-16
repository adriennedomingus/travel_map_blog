class AddTripToBlog < ActiveRecord::Migration
  def change
    add_reference :blogs, :trip, index: true, foreign_key: true
  end
end
