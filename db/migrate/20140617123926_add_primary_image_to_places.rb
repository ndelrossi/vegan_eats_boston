class AddPrimaryImageToPlaces < ActiveRecord::Migration
  def self.up
    add_attachment :places, :primary_image
  end

  def self.down
    remove_attachment :places, :primary_image
  end
end
