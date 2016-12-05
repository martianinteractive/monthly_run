class RemoveSignedBy < ActiveRecord::Migration
  def change
    remove_column :leases, :signed_by
  end
end
