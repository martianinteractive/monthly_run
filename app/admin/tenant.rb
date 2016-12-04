ActiveAdmin.register Tenant do

  config.clear_action_items!
  
  scope :active, default: true
  scope :inactive

  menu priority: 3

  index do 
    column "Full Name" do |f|
      link_to "#{f.full_name}", admin_tenant_path(f)
    end

    column "Email" do |f|
      f.email
    end

    column "Mobile" do |f|
      f.mobile
    end

    column "Leased Unit" do |f|
      f.rented_address
    end
  end

end
