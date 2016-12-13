class RemoveCounty < ActiveRecord::Migration
  def change
    remove_column :properties, :county, :string
    remove_column :units, :county, :string
  end
end
