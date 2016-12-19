class AddLeasesPreferrredPayment < ActiveRecord::Migration
  def change
    add_column :leases, :preferred_payment_method, :string
  end
end
