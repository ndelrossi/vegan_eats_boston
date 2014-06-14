class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.string :url_website
      t.string :url_menu
      t.string :address_line_1
      t.string :address_line_2
      t.string :address_city
      t.string :address_state
      t.string :address_zip_code
      t.string :phone_number

      t.timestamps
    end
    add_index :places, [:created_at]
  end
end
