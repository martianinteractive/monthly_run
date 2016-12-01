class PropertyIsRentalUnit < ActiveRecord::Migration
  def change
    add_column :properties, :is_rental_unit, :boolean, default: false, nil: false
  end
end
