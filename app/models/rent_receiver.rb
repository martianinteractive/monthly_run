class RentReceiver
  attr_accessor :lease, :amount_due, :amount_collected, :month, :collected_at, :received_via

  def initialize(lease, options={})
    @lease = lease
    @amount_due = options.fetch(:amount_due, lease.amount_due)
    @amount_collected = options.fetch(:amount_collected, lease.amount_due)
    @month = options.fetch(:month, Date.today.month)
    @collected_at = options.fetch(:collected_at, DateTime.now)
    @received_via = options.fetch(:received_via, lease.preferred_payment_method)
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
      })
  end
end
