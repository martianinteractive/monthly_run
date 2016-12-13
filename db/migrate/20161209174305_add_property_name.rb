class AddPropertyName < ActiveRecord::Migration
  def change
    add_column :properties, :name, :string
    add_column :units, :name, :string
  end
end
