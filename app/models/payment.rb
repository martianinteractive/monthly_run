class Payment < ActiveRecord::Base
  belongs_to :lease
  belongs_to :admin_user
  belongs_to :charge

  default_scope { order(created_at: :desc) }

  monetize :amount_due_in_cents, allow_nil: false
  monetize :amount_collected_in_cents, allow_nil: false

  delegate :formatted_address, to: :lease
  delegate :amount_due, to: :lease
  delegate :charges, to: :lease, prefix: :lease

  validates :admin_user, presence: true

  scope :paid_period, ->(date=Time.zone.now.to_date) { where("applicable_period >= ? AND applicable_period <= ?", date.beginning_of_month, date.end_of_month) }
  
  def self.unpaid_period(date)
    Lease.active.where("id NOT IN (#{leases_paid_sql(date)})").where(Lease.arel_table[:starts_on].lt(date))
  end

  def self.leases_paid_sql(date)
    select(:lease_id).paid_period(date).to_sql
  end
  
end
