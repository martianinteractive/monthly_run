ActiveAdmin.register Lease, as: "Rent" do

  config.filters = true
  config.batch_actions = false

  scope "All", :balance, default: true

  filter :balance, as: :select, collection: {"This Month" => Time.zone.today.to_date, "Last Month" => 1.month.ago }

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

    column :collected_on do |f|
      f.collected_on
    end

  end

end
