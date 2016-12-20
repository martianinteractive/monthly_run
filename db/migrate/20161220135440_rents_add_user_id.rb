class RentsAddUserId < ActiveRecord::Migration
  def change
    add_reference :rents, :user
    remove_column :rents, :received_by, :string
  end
end
