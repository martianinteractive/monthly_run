class AddLeasesAddRentDueAndGracePeriod < ActiveRecord::Migration
  def change
    add_column :leases, :rent_due, :integer, default: 1
    add_column :leases, :grace_period_in_days, :integer, default: 1
    remove_column :units, :rent_due
  end
end
