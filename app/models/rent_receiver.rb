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

  def self.process!(lease, options)
    rent_receiver = self.new(lease, options)
    rent_receiver.create_lease
  end

  def create_lease
    lease.payments.create({
      amount_due: amount_due,
      amount_collected: amount_collected,
      collected_on: collected_on,
      received_via: received_via,
      applicable_period: applicable_period,
      admin_user: admin_user
      })
  end
end
