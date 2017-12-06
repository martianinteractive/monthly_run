ActiveAdmin.register Lease, as: "Rent" do

  config.filters = false
  config.batch_actions = false

  scope "All", :balance, default: true


  index do 
    column :unit do |f|
      link_to "#{f.unit.formatted_address}", admin_lease_path(f)
    end

    column :charge do |f|
      f.charge_name
    end

    column :amount do |f|
      f.charge_amount_in_cents
    end

    column :collected do |f|
      f.amount_collected_cents
    end

  end

end
