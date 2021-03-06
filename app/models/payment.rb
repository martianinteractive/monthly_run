class Payment < ActiveRecord::Base
  belongs_to :lease
  belongs_to :admin_user
  belongs_to :charge

  by_star_field :applicable_period

  default_scope { order(created_at: :desc) }

  monetize :amount_due_in_cents, allow_nil: false
  monetize :amount_collected_in_cents, allow_nil: false

  delegate :formatted_address, to: :lease
  delegate :charges, to: :lease, prefix: :lease
  delegate :unit, to: :lease
  delegate :formatted_address, to: :unit, prefix: true
  delegate :name, to: :charge, prefix: true

  validates :admin_user, :applicable_period, presence: true

  scope :for_month, ->(date=Time.zone.now.to_date) { 
    date = date.is_a?(String) ? Chronic.parse(date.humanize) : date
    by_month(date.month, year: date.year) 
  }

  scope :unpaid, -> () {
# SELECT p.lease_id, charges.* FROM payments p LEFT JOIN charges ON charges.id = p.charge_id WHERE NOT EXISTS(SELECT c.* FROM charges c WHERE c.id = p.charge_id AND (p.applicable_period >= '2017-09-01 00:00:00' AND p.applicable_period <= '2017-09-30 23:59:59.999999')) GROUP BY p.lease_id, charges.id
  }

  scope :balance, -> (date=Time.zone.now.to_date) {
    joins("LEFT JOIN leases l ON l.id = payments.lease_id AND payments.applicable_period between '#{date.beginning_of_month}' AND '#{date.end_of_month}' RIGHT JOIN units u on u.id = l.unit_id WHERE CURRENT_DATE < l.ends_on")
  }

  def self.for_period(date)
    for_month(date).first
  end
  
end
