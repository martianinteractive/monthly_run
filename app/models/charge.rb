class Charge < ActiveRecord::Base
  FREQUENCY = [:monthly, :one_time]

  belongs_to :lease
  has_many :payments

  scope :unpaid, -> { includes(:payments).where(payments: {charge_id: nil}) }

  monetize :amount_in_cents, allow_nil: false
  validates :name, :frequency, presence: true

end
