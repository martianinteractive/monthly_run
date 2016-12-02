ActiveAdmin.register Property do

  menu priority: 1

  controller do
    def build_new_resource(attributes={})
      if Account.count == 1
        attributes = attributes.merge(account: Account.first)
      end
      Property.new(attributes)
    end
  end

  index do
    column :address
    column :city
    column :state
    column :zip
    actions
  end

  form partial: 'form'

end
