module PaymentsHelper

  def selected_period
    period ||= params[:period].present? ? Chronic.parse(params[:period]) : Time.zone.now.to_date
    Lease.monthly_balance(period)
  end

  def last_month
    Time.zone.now.to_date - 1.month
  end

  def this_month
    Time.zone.now.to_date
  end

  def next_month
    Time.zone.now.to_date + 1.month
  end

  def for_month(month)
    Lease.monthly_balance(month)
  end

  def active_leases_options
    Lease.active.select {|s| [s.id, s.name]}
  end

  def payment_due?(lease)
    lease.payments_count < lease.charges_count
  end
end
