ActiveAdmin.register Unit do
  menu priority: 4

  index do
    column :address
    column :city
    column :state
    column :zip
    actions
  end

end
