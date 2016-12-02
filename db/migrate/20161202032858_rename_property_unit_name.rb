class RenamePropertyUnitName < ActiveRecord::Migration
  def change
    remove_column :properties, :unit_name
    add_column :properties, :unit_type_id, :integer
  end
end
