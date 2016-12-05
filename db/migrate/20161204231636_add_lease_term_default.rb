class AddLeaseTermDefault < ActiveRecord::Migration
  def change
    change_column :leases, :length_in_months, :integer, default: 12, null: false
  end
end
