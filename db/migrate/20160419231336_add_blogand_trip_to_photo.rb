class AddBlogandTripToPhoto < ActiveRecord::Migration
  def change
    add_reference :photos, :blog, index: true, foreign_key: true
    add_reference :photos, :trip, index: true, foreign_key: true
  end
end
