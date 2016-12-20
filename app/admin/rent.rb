ActiveAdmin.register Rent do
  config.filters = false

  belongs_to :lease, optional: true

  index do
    render 'index'
  end

  show do
    render 'show'
  end

  member_action :receive, method: :put do
    lease.receive_rent!(user: current_admin_user)
    redirect_to admin_rents_path, notice: "Rent received!"
  end


  controller do
    layout 'active_admin' 

    def lease
      Lease.find(params[:id])
    end

    def collection
      @rents_unpaid = Rent.unpaid_this_month
      @rents_paid = Rent.order(created_at: :desc).paid_this_month
    end
  end



end
