ActiveAdmin.register Unit do
  menu priority: 4

  action_item :only => [:show] do
    link_to "New Lease", new_admin_unit_lease_path(resource)
  end

  show do
    render 'show'
  end

  index do
    column "address" do |unit|
      link_to unit.address, admin_unit_path(unit)
    end
    column :city
    column :state
    column :zip
  end

  form partial: 'form'

  permit_params :address, :number, :city, :state, :zip, :country, :unit_type_id, :rent_due, :dimension, :notes
                

end
