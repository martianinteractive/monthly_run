class Payment < ActiveRecord::Base
  belongs_to :lease
  belongs_to :admin_user
  belongs_to :charge

  by_star_field :applicable_period

  default_scope { order(created_at: :desc) }

  monetize :amount_due_in_cents, allow_nil: false
  monetize :amount_collected_in_cents, allow_nil: false

  delegate :formatted_address, to: :lease
  delegate :amount_due, to: :lease
  delegate :charges, to: :lease, prefix: :lease

  validates :admin_user, :applicable_period, presence: true

  scope :by_pay_period, ->(date=Time.zone.now.to_date) { by_month(date.month, year: date.year) }
  
end
