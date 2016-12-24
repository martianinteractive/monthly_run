ActiveAdmin.register Account do

  before_create do |order|
    resource.admin_user = current_admin_user
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :active
    end
    f.actions
  end

  permit_params :name

  filter :name 
  
  index do
    column :name
    column "Created", :created_at
  end

  show do
    attributes_table do
      row :name
    end
  end

end
