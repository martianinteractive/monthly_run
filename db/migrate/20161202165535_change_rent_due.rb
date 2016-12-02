class ChangeRentDue < ActiveRecord::Migration
  def change
    remove_column :units, :rent_due
    remove_column :properties, :rent_due
    add_column :units, :rent_due, :integer, default: 1, nil: false
    add_column :properties, :rent_due, :integer, default: 1, nil: false
  end
end
