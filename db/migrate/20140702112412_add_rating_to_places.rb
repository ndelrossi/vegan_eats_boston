class AddRatingToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :rating, :integer, default: 0
  end
end
