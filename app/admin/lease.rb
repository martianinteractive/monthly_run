ActiveAdmin.register Lease do

  scope :active, default: true
  scope :inactive
  
  config.clear_action_items!

  action_item :edit, only: :show do
    link_to "Edit Lease", edit_admin_lease_path(resource)
  end

  belongs_to :unit, optional: true

  menu priority: 2

  permit_params :starts_on, :ends_on, tenants_attributes: [:id, :full_name, :email, :mobile, :work_phone, :home_phone, :signee, :primary, :_destroy], charges_attributes: [:id, :name, :frequency, :amount, :_destroy]

  show do
    render 'show'
  end

  before_action :active_lease, only: [:new]

  controller do
    def active_lease
      @unit = Unit.find(params[:unit_id])
      
      if @unit.has_active_lease?
        flash[:warning] = "Unit has an active lease."
      end
    end

    def build_new_resource
      return super if resource_params.first.present?
      charge = Charge.new(name: "Rent", frequency: 'monthly')
      Lease.new(charges: [charge])
    end

    def create_resource(object)
      object.admin_user = current_admin_user
      object.save
    end

  end

  filter :ends_on, label: "Ends between:"
  filter :starts_on, label: "Starts between:"

  index do 
    column :unit do |f|
      link_to "#{f.unit.formatted_address}", admin_lease_path(f)
    end

    column "Started" do |f|
      f.starts_on
    end

    column "Ends in", sortable: :ends_on do |f|
      distance_of_time_in_words_to_now(f.ends_on)
    end

    column "Mo. Rent" do |f|
      number_to_currency(f.monthly_rent)
    end
  end

  form do |f|
    f.inputs name: "Details" do
      f.input :starts_on, label: "Lease starts on", as: :date_picker
      f.input :ends_on, label: "Lease ends on", as: :date_picker
    end

    f.inputs name: "Tenants" do
      f.has_many :tenants, allow_destroy: true do |f|
        f.input :full_name
        f.input :email
        f.input :mobile, as: :phone, input_html: { class: "phone_us" }
        f.input :work_phone, as: :phone, input_html: { class: "phone_us" }
        f.input :home_phone, as: :phone, input_html: { class: "phone_us" }
        f.input :signee, hint: "Check if the tenant has signed the contract."
        f.input :primary, hint: "Check if the tenant is the primary leasee."
      end
    end

    f.inputs name: "Charges" do
      f.has_many :charges, allow_destroy: true do |f|
        f.input :name
        f.input :frequency, as: :select, collection: frequency_options
        f.input :amount, as: :number, input_html: { style: "width: 200px;" }
      end
    end

    f.actions
  end
    

end
