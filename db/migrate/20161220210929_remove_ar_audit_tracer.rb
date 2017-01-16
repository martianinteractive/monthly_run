class RemoveArAuditTracer < ActiveRecord::Migration
  def change
    # remove_column :accounts, :updated_by, :string
    # remove_column :accounts, :created_by, :string
    # remove_column :admin_users, :updated_by, :string
    # remove_column :admin_users, :created_by, :string
    # remove_column :leases, :updated_by, :string
    # remove_column :leases, :created_by, :string
    # remove_column :properties, :updated_by, :string
    # remove_column :properties, :created_by, :string
    # remove_column :tenants, :updated_by, :string
    # remove_column :tenants, :created_by, :string
    # remove_column :units, :updated_by, :string
    # remove_column :units, :created_by, :string
    # remove_column :users, :updated_by, :string
    # remove_column :users, :created_by, :string

    add_column :accounts, :admin_user_id, :integer
    add_column :leases, :admin_user_id, :integer
    add_column :properties, :admin_user_id, :integer
    add_column :tenants, :admin_user_id, :integer
    add_column :units, :admin_user_id, :integer
    add_column :users, :admin_user_id, :integer

  end
end
