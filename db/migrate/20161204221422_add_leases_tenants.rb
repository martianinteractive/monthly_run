class AddLeasesTenants < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.references :lease
      t.references :tenant
      t.timestamps null: false
    end

    remove_column :leases, :terms
    remove_column :tenants, :lease_id
  end
end
