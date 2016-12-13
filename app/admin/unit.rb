ActiveAdmin.register Unit do
  menu priority: 4

  filter :unit_type
  filter :address
  filter :county
  filter :city
  filter :zip

  action_item :only => [:show] do
    link_to "New Lease", new_admin_unit_lease_path(resource)
  end

  show do
    render 'show'
  end

  index do
    column "address" do |unit|
      link_to unit.formatted_address, admin_unit_path(unit)
    end
    column :county
  end

  form partial: 'form'

  permit_params :number, :address, :latitude, :longitude, :location, :location_type, :formatted_address, :bounds, :viewport, :route, :street_number, :postal_code, :locality, :sublocality, :country_short, :administrative_area_level_1, :administrative_area_level_2, :place_id, :reference, :url, :unit_type_id, :rent_due, :dimension, :notes
                

end
