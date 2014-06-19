class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :content
      t.integer :rating
      t.integer :user_id
      t.integer :place_id

      t.timestamps
    end
    add_index :reviews, [:rating, :user_id, :place_id, :created_at]
  end
end
