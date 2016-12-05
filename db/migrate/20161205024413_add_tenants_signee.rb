class AddTenantsSignee < ActiveRecord::Migration
  def change
    add_column :tenants, :signee, :boolean, default: false
    add_column :tenants, :primary, :boolean, default: false
  end
end
