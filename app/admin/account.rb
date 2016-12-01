ActiveAdmin.register Account do

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
