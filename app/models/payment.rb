class Payment < ActiveRecord::Base
  belongs_to :lease
  belongs_to :admin_user
  belongs_to :charge

  monetize :amount_due_in_cents, allow_nil: false
  monetize :amount_collected_in_cents, allow_nil: false

  delegate :formatted_address, to: :lease
  delegate :amount_due, to: :lease

  validates :admin_user, presence: true

  scope :paid_for_date, ->(date=Time.zone.now.to_date) { where("applicable_period >= ? AND applicable_period < ?", date.beginning_of_month, date.end_of_month) }
  
  def self.unpaid_for_date(date)
    Lease.active.where("id NOT IN (#{select(:lease_id).paid_for_date(date).to_sql})")
  end
  
end
