ActiveAdmin.register Payment do
  config.filters = false

  before_create do |order|
    resource.admin_user = current_admin_user
  end

  belongs_to :lease, optional: true

  form partial: 'form'

  member_action :receive, method: :put do

    lease.receive_full_payment!({
      admin_user:         current_admin_user, 
      applicable_period:  applicable_period
      })
    
    redirect_to admin_payments_path(anchor: anchor), notice: "Rent received!"
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

    def index
      index! do |format|
        format.html { render 'index', layout: "active_admin" }
      end
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
