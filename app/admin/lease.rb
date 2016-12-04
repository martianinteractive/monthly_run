ActiveAdmin.register Lease do

  belongs_to :unit, optional: true

  menu priority: 2

  permit_params :starts_on, :length_in_months, :signed_by, :security_deposit, :monthly_amount, tenants_attributes: [:id, :full_name, :email, :mobile, :work_phone, :home_phone, :_destroy]

  # index do 
  #   column :unit do |f|
  #     f.unit.address  
  #   end
  # end

  form do |f|
    f.inputs name: "Details" do
      f.input :starts_on, as: :date_picker
      f.input :length_in_months, as: :number
      f.input :signed_by
      f.input :security_deposit
      f.input :monthly_amount
    end

    f.inputs name: "Tenants" do
      f.has_many :tenants do |f|
        f.input :full_name
        f.input :email
        f.input :mobile, as: :phone
        f.input :work_phone, as: :phone
        f.input :home_phone, as: :phone
      end
    end

    f.actions
  end
    

end
