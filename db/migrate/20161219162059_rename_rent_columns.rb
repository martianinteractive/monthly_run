class RenameRentColumns < ActiveRecord::Migration
  def change
    rename_column :rents, :rent_due_in_cents, :amount_due_in_cents
    rename_column :rents, :rent_collected_in_cents, :amount_collected_in_cents
  end
end
