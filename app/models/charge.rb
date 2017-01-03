class Charge < ActiveRecord::Base
  FREQUENCY = [:monthly, :one_time]

  belongs_to :lease
  has_many :payments

  monetize :amount_in_cents, allow_nil: false
  validates :name, :frequency, presence: true

  def self.total_amount
    Money.new(sum(:amount_in_cents))
  end

end
