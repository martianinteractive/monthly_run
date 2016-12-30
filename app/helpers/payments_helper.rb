module PaymentsHelper

  def selected_period
    period ||= params[:period].present? ? Chronic.parse(params[:period]) : Time.zone.now.to_date
    {
      paid: Payment.paid_period(period),
      unpaid: Payment.unpaid_period(period)
    }
  end

  def last_month
    month = Time.zone.now.to_date - 1.month

    @last_month ||= {
      paid:   Payment.paid_period(month),
      unpaid: Payment.unpaid_period(month)
    }
  end

  def this_month
    month = Time.zone.now.to_date

    @this_month ||= {
      paid:   Payment.paid_period(month),
      unpaid: Payment.unpaid_period(month)
    }
  end

  def next_month
    month = Time.zone.now.to_date + 1.month

    @last_month ||= {
      paid:   Payment.paid_period(month),
      unpaid: Payment.unpaid_period(month)
    }
  end

  def active_leases_options
    Lease.active.select {|s| [s.id, s.name]}
  end
end
