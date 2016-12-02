class PropertyCountry < ActiveRecord::Migration
  def up
    change_column :properties, :country, :string, default: "US"
    change_column :units, :country, :string, default: "US"
  end

  def down
    change_column :properties, :country, :string, default: "US"
    change_column :units, :country, :string, default: "US"
  end
end
