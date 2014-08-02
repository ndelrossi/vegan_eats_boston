class AddReviewsCountToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :reviews_count, :integer
  end
end
