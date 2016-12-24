class AddRentsApplyToPeriod < ActiveRecord::Migration
  def change
    add_column :rents, :applicable_period, :date
  end
end
