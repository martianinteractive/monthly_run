ActiveAdmin.register Rent do
  config.filters = false

  belongs_to :lease, optional: true

  index do
    render 'index'
  end

  member_action :receive, method: :put do
    lease.receive_rent!
    redirect_to admin_rents_path, notice: "Rent received!"
  end


  controller do
    layout 'active_admin' 

    def lease
      Lease.find(params[:id])
    end

    def collection
      @rents_unpaid = Rent.unpaid_this_month
      @rents_paid = Rent.paid_this_month
    end
  end



end
