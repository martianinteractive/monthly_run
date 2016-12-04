class LeaseAddEndOn < ActiveRecord::Migration
  def change
    add_column :leases, :ends_on, :date
  end
end
