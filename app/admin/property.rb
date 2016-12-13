ActiveAdmin.register Property do

  menu priority: 1

  filter :account
  filter :county
  filter :city
  filter :zip

  controller do
    def build_new_resource(attributes={})
      if Account.count == 1
        attributes = attributes.merge(account: Account.first)
      end
      Property.new(attributes)
    end
  end

  index do
    column :address do |p|
      p.formatted_address
    end

    column :county
    
    actions
  end

  show do
    attributes_table do
      row :formatted_address
      row :tax_number
      row :created_at
      row :account
      row "created by" do |p|
        AdminUser.find(p.created_by).full_name
      end
    end
  end

  form partial: 'form'

  permit_params :latitude, :longitude, :location, :location_type, :formatted_address, :bounds, :viewport, :route, :street_number, :postal_code, :locality, :sublocality, :country_short, :administrative_area_level_1, :administrative_area_level_2, :place_id, :reference, :url, :account_id, :name, :unit_type_id, :is_rental_unit, :rent_due

end
