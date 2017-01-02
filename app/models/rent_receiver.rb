class RentReceiver

  VALID_APPLICABLE_PERIODS = ['next_month', 'last_month', 'this_month']

  attr_accessor :lease, :amount_due, :amount_collected, :collected_on, :received_via, :admin_user

  def initialize(lease, options={})
    raise ArgumentError, "No Lease!" unless lease.is_a?(Lease)
    @lease = lease
    @amount_due = options.fetch(:amount_due, lease.amount_due)
    @admin_user = options.fetch(:admin_user, nil)
    @amount_collected = options.fetch(:amount_collected, lease.amount_due)
    @collected_on = options.fetch(:collected_on, Time.zone.now.to_date)
    @received_via = options.fetch(:received_via, lease.preferred_payment_method)
    @applicable_period = options.fetch(:applicable_period, Time.zone.now.to_date)
  end

  def applicable_period
    if @applicable_period.is_a?(String)
      Chronic.parse(@applicable_period)
    else
      @applicable_period
    end
  end

  def self.process_full_payment!(lease, options)
    rent_receiver = self.new(lease, options)
    rent_receiver.create_payments
  end

  def create_payments
    create_periodic_payments
    create_one_time_payments
  end

  private

  def create_periodic_payments
    lease.periodic_charges.each {|charge| create_payment(charge) }
  end

  def create_one_time_payments
    return unless lease.one_time_charges.any?
    lease.one_time_charges.unpaid.each {|charge| create_payment(charge) }
  end

  def create_payment(charge)
    lease.payments.create!({
      amount_due: charge.amount,
      amount_collected: charge.amount,
      collected_on: collected_on,
      received_via: received_via,
      charge: charge,
      applicable_period: applicable_period,
      admin_user: admin_user
    })
  end
end
