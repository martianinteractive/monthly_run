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

  form partial: 'form'

  # form do |f|
  #   inputs 'Details' do
  #     input :name
  #     input :address, as: :text
  #     input :city
  #   end
  # end

end
