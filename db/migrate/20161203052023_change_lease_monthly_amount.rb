class ChangeLeaseMonthlyAmount < ActiveRecord::Migration
  def up
    remove_column :leases, :monthly_amount_in_cents
    add_monetize :leases, :monthly_amount
  end

  def down
    add_column :leases, :monthly_amount_in_cents, :integer
    remove_monetize :leases, :monthly_amount
  end
end
