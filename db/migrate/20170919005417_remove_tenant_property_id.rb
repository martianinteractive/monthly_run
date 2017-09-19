class RemoveTenantPropertyId < ActiveRecord::Migration[5.1]
  def change
    remove_column :tenants, :property_id
  end
end
