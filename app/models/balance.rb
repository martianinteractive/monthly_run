class Balance

  def initialize(applicable_date)
    @applicable_date = applicable_date
    @start_date = applicable_date.beginning_of_month
    @end_date = applicable_date.end_of_month
  end

  def today
    Lease.joins("LEFT JOIN payments p ON leases.id = p.lease_id AND p.applicable_period between '#{@start_date}' AND '#{@end_date}' WHERE CURRENT_DATE < leases.ends_on")
  end

end
