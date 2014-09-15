class ChangeDescriptionToPlaces < ActiveRecord::Migration
  def change
    change_column_default(:places, :description, nil)
  end
end
