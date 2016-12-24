class RentReceiver

  VALID_APPLICABLE_PERIODS = ['next_month', 'last_month', 'this_month']

  attr_accessor :lease, :amount_due, :amount_collected, :month, :collected_at, :received_via, :admin_user

  def initialize(lease, options={})
    raise ArgumentError, "No Lease!" unless lease.is_a?(Lease)
    @lease = lease
    @amount_due = options.fetch(:amount_due, lease.amount_due)
    @admin_user = options.fetch(:admin_user, nil)
    @amount_collected = options.fetch(:amount_collected, lease.amount_due)
    @month = options.fetch(:month, Date.today.month)
    @collected_at = options.fetch(:collected_at, DateTime.now)
    @received_via = options.fetch(:received_via, lease.preferred_payment_method)
    @applicable_period = options.fetch(:applicable_period, DateTime.now)
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
    lease.rents.create({
      month: month,
      amount_due: amount_due,
      amount_collected: amount_collected,
      collected_at: collected_at,
      received_via: received_via,
      applicable_period: applicable_period,
      admin_user: admin_user
      })
  end
end
