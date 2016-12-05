class AddPropertyCounty < ActiveRecord::Migration
  def change
    add_column :properties, :county, :string
    add_column :units, :county, :string
  end
end
