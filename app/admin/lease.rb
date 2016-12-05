ActiveAdmin.register Lease do

  scope :active, default: true
  scope :inactive
  
  config.clear_action_items!

  belongs_to :unit, optional: true

  menu priority: 2

  permit_params :starts_on, :length_in_months, :signed_by, :security_deposit, :monthly_rent, tenants_attributes: [:id, :full_name, :email, :mobile, :work_phone, :home_phone, :_destroy]

  show do
    render 'show'
  end

  before_filter :active_lease, only: [:new]

  controller do
    def active_lease
      @unit = Unit.find(params[:unit_id])
      if @unit.has_active_lease?
        flash[:warning] = "Unit has an active lease."
      end
    end
  end

  filter :ends_on, label: "Ends between:"
  filter :starts_on, label: "Starts between:"
  filter :monthly_rent_in_cents, label: "Monthly Rent:"

  index do 
    column :unit do |f|
      link_to "#{f.unit.full_address}", admin_lease_path(f)
    end

    column "Started" do |f|
      f.starts_on
    end

    column "Ends in", sortable: :ends_on do |f|
      distance_of_time_in_words_to_now(f.ends_on)
    end

    column "Mo. Rent", sortable: :monthly_rent_in_cents do |f|
      number_to_currency(f.monthly_rent)
    end
  end

  form do |f|
    f.inputs name: "Details" do
      f.input :starts_on, as: :date_picker
      f.input :length_in_months, as: :number
      f.input :signed_by
      f.input :security_deposit
      f.input :monthly_rent
    end

    f.inputs name: "Tenants" do
      f.has_many :tenants do |f|
        f.input :full_name
        f.input :email
        f.input :mobile, as: :phone
        f.input :work_phone, as: :phone
        f.input :home_phone, as: :phone
        f.input :signee, hint: "Check if the tenant has signed on the contract."
        f.input :primary, hint: "Check if the tenant is the primary renter."
      end
    end

    f.actions
  end
    

end
