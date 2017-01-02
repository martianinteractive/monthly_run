class AddPeriodRange < ActiveRecord::Migration
  def change
    add_column :leases, :period, :daterange
    remove_column :leases, :starts_on, :date
    remove_column :leases, :ends_on, :date
  end
end
