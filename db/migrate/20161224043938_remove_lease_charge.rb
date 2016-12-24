class RemoveLeaseCharge < ActiveRecord::Migration
  def change
    remove_column :leases, :security_deposit_in_cents
    remove_column :leases, :security_deposit_currency
    remove_column :leases, :monthly_rent_in_cents
    remove_column :leases, :monthly_rent_currency
    remove_column :leases, :pet_fee_in_cents
    remove_column :leases, :pet_fee_currency
  end

end
