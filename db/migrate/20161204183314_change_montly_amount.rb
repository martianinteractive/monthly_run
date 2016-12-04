class ChangeMontlyAmount < ActiveRecord::Migration
  def change
    rename_column :leases, :monthly_amount_in_cents, :monthly_rent_in_cents
    rename_column :leases, :monthly_amount_currency, :monthly_rent_currency
  end
end
