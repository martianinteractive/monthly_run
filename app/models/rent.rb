class Rent < ActiveRecord::Base
  belongs_to :lease
  belongs_to :user, class_name: "AdminUser"

  monetize :amount_due_in_cents, allow_nil: false
  monetize :amount_collected_in_cents, allow_nil: false

  delegate :formatted_address, to: :lease
  delegate :amount_due, to: :lease

  validates :user, presence: true

  scope :paid_this_month, -> { where("date_trunc('month', created_at) = date_trunc('month', current_date)") }

  def self.unpaid_this_month
    Lease.active.where("id NOT IN (#{current_rent_sql})")
  end

  def self.current_rent_sql
    Rent.select(:lease_id).paid_this_month.to_sql
  end
end
