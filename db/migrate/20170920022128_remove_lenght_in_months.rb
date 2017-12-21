class RemoveLenghtInMonths < ActiveRecord::Migration[5.1]
  def change
    remove_column :leases, :length_in_months, :integer, default: 12
  end
end
