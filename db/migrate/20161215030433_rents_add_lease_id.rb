class RentsAddLeaseId < ActiveRecord::Migration
  def change
    add_reference :rents, :lease, index: true
  end
end
