ActiveAdmin.register Payment do

  before_create do |order|
    resource.admin_user = current_admin_user
  end

  # scope :accumulated_balance do |payments|
  # end

  belongs_to :unit, optional: true

  form partial: 'form'

  member_action :receive, method: :put do

    lease.receive_full_payment!({
      admin_user:         current_admin_user, 
      applicable_period:  applicable_period
      })
    
    redirect_to admin_payments_path(anchor: anchor), notice: "Rent received!"
  end

  filter :applicable_period
  filter :lease_unit_id, as: :select, collection: Unit.distinct.pluck(:name, :id)
  filter :charge_name, as: :select, collection: Charge.distinct.pluck(:name)

  index do
    column :unit_address do |p|
      p.formatted_address
    end

    column :charge_name do |p|
      p.charge_name
    end

    column :amount_due do |p|
      number_to_currency p.amount_due
    end

    column :period do |p|
      p.applicable_period.strftime('%B %Y')
    end

    column :collected_on do |p|
      p.collected_on
    end

    column :amount_collected do |p|
      number_to_currency p.amount_collected
    end
  end

  controller do

    def build_new_resource(attributes={})
      if params[:lease_id]
        lease = Lease.find(params[:lease_id])
        attributes = attributes.merge(lease: lease)
      end
      Payment.new(attributes)
    end

    def create
      @payment = Payment.new(payment_params)
      @payment.admin_user = current_admin_user
      create!
    end

    def payment_params
      params[:payment].permit!
    end

    def lease
      Lease.find(params[:id])
    end

    def applicable_period
      params[:applicable_period]
    end

    def anchor
      applicable_period.to_s.tr(' ', '_')
    end
  end

end
