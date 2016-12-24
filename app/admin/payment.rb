ActiveAdmin.register Payment do
  config.filters = false

  before_create do |order|
    resource.admin_user = current_admin_user
  end

  belongs_to :lease, optional: true

  index do
    render 'index'
  end

  show do
    render 'show'
  end

  member_action :receive, method: :put do

    lease.receive_rent!({
      admin_user:         current_admin_user, 
      applicable_period:  params[:applicable_period]
      })
    
    redirect_to admin_payments_path, notice: "Rent received!"
  end


  controller do
    layout 'active_admin' 

    def lease
      Lease.find(params[:id])
    end

    def collection
      today = Time.zone.now.to_date

      @rents_unpaid_last_month = Payment.unpaid_for_date(today - 1.month)
      @rents_paid_last_month = Payment.paid_for_date(today - 1.month)

      @rents_unpaid_this_month = Payment.unpaid_for_date(today)
      @rents_paid_this_month = Payment.order(created_at: :desc).paid_for_date(today)

      @rents_unpaid_next_month = Payment.unpaid_for_date(today + 1.month)
      @rents_paid_next_month = Payment.order(created_at: :desc).paid_for_date(today + 1.month)
    end
  end

end
