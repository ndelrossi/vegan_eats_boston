class AddDescriptionToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :description, :text, :default => "Click here as admin to add description."
  end
end
