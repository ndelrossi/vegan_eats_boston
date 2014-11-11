class ChangeAddressStreetInPlaces < ActiveRecord::Migration
  def change
    change_column :places, :address_state, :string, :default => 'MA'
  end
end
