class UnitsAddRentDue < ActiveRecord::Migration
  def change
    add_column :units, :rent_due, :string
  end
end
