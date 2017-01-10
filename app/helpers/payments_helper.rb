module PaymentsHelper

  def selected_period
    period ||= params[:period].present? ? Chronic.parse(params[:period]) : Time.zone.now.to_date
    {
      paid: Lease.paid_for_month(period),
      unpaid: Lease.payable_for_month(period)
    }
  end

  def last_month
    month = Time.zone.now.to_date - 1.month

    @last_month ||= {
      paid:   Lease.paid_for_month(month),
      unpaid: Lease.payable_for_month(month)
    }
  end

  def this_month
    month = Time.zone.now.to_date

    @this_month ||= {
      paid:   Lease.paid_for_month(month),
      unpaid: Lease.payable_for_month(month)
    }
  end

  def next_month
    month = Time.zone.now.to_date + 1.month

    @next_month ||= {
      paid:   Lease.paid_for_month(month),
      unpaid: Lease.payable_for_month(month)
    }
  end

  def active_leases_options
    Lease.active.select {|s| [s.id, s.name]}
  end
end
