class UpdatePlaceInfo < ActiveRecord::Migration
  def change
    remove_column :properties, :name, :string
    remove_column :properties, :address, :string
    remove_column :properties, :city, :string
    remove_column :properties, :state, :string
    remove_column :properties, :zip, :string
    remove_column :properties, :country, :string
    remove_column :units, :address, :string
    remove_column :units, :city, :string
    remove_column :units, :state, :string
    remove_column :units, :zip, :string
    remove_column :units, :country, :string
    add_column :properties, :latitude, :string
    add_column :properties, :longitude, :string
    add_column :properties, :location, :string
    add_column :properties, :location_type, :string
    add_column :properties, :formatted_address, :string
    add_column :properties, :bounds, :string
    add_column :properties, :viewport, :string
    add_column :properties, :route, :string
    add_column :properties, :street_number, :string
    add_column :properties, :postal_code, :string
    add_column :properties, :locality, :string
    add_column :properties, :sublocality, :string
    add_column :properties, :country, :string
    add_column :properties, :country_short, :string
    add_column :properties, :administrative_area_level_1, :string
    add_column :properties, :administrative_area_level_2, :string
    add_column :properties, :place_id, :string
    add_column :properties, :reference, :string
    add_column :properties, :url, :string
    add_column :units, :latitude, :string
    add_column :units, :longitude, :string
    add_column :units, :location, :string
    add_column :units, :location_type, :string
    add_column :units, :formatted_address, :string
    add_column :units, :bounds, :string
    add_column :units, :viewport, :string
    add_column :units, :route, :string
    add_column :units, :street_number, :string
    add_column :units, :postal_code, :string
    add_column :units, :locality, :string
    add_column :units, :sublocality, :string
    add_column :units, :country, :string
    add_column :units, :country_short, :string
    add_column :units, :administrative_area_level_1, :string
    add_column :units, :administrative_area_level_2, :string
    add_column :units, :place_id, :string
    add_column :units, :reference, :string
    add_column :units, :url, :string
  end
end
