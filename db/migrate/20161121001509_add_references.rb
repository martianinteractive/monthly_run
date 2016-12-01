class AddReferences < ActiveRecord::Migration
  def change
    add_reference :units, :unit_type
    add_reference :leases, :unit
  end
end
