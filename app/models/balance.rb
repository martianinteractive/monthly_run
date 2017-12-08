class Balance < ActiveRecord::Base
  self.table_name = 'leases'

  belongs_to :unit
  has_many :payments

  default_scope { this_month }

  # scope :by_period, -> (date) {
  #   unscoped.special_query(date)
  # }

  scope :month, -> {
    LeasedUnits.new(self).join
  }

  scope :paid, -> {
    date = Time.zone.today.to_date
    select("leases.*", "c.name AS charge_name", "c.amount_in_cents AS charge_amount_in_cents", "payments.amount_collected_in_cents AS amount_collected_cents", "payments.collected_on").
    joins("LEFT JOIN units u ON leases.unit_id = u.id LEFT JOIN charges c ON c.lease_id = leases.id INNER JOIN payments ON leases.id = payments.lease_id AND payments.applicable_period BETWEEN '#{date.beginning_of_month}' AND '#{date.end_of_month}'").
    where("CURRENT_DATE < leases.ends_on AND c.frequency = 'monthly'")
  }

  scope :this_month, -> {
    special_query(Time.zone.now.to_date)
  }

  def self.special_query(date)
    date = date.is_a?(Date) ? date : Date.parse(date)
    select("leases.*", "c.name AS charge_name", "c.amount_in_cents AS charge_amount_in_cents", "payments.amount_collected_in_cents AS amount_collected_cents", "payments.collected_on").
      joins("LEFT JOIN units u ON leases.unit_id = u.id LEFT JOIN charges c ON c.lease_id = leases.id LEFT JOIN payments ON leases.id = payments.lease_id AND payments.applicable_period BETWEEN '#{date.beginning_of_month}' AND '#{date.end_of_month}'").
      where("CURRENT_DATE < leases.ends_on AND c.frequency = 'monthly'")
  end

  def self.ransackable_scopes(auth_object=nil)
    [:by_period]
  end

end

class LeaseCharge < Struct.new(:lease)
  def join
    lease.joins(charges, Arel::Nodes::OuterJoin).on(leases[:id].eq(charges[:lease_id]))
  end

  def leases
    Lease.arel_table
  end

  def charges
    Charge.arel_table
  end
end


class LeasedUnits < Struct.new(:lease)
  def join
    lease.joins(units, Arel::Nodes::OuterJoin).on(units[:id].eq(leases[:unit_id]))
  end

  def units
    Unit.arel_table
  end

  def leases
    Lease.arel_table
  end
end


class LeasePayments < Struct.new(:lease)

  def payment_applicable_period
    payment[:applicable_period]
  end

  def join
    Arel::Nodes::OuterJoin.new(payments, on)
  end

  def on
    Arel::Nodes::On.new(equality_condition)
  end

# on = Arel::Nodes::On.new(
#   Arel::Nodes::Equality.new(Schedule.arel_table[:shift_id], Shift.arel_table[:id]).\
#   and(Arel::Nodes::Between.new(
#     Schedule.arel_table[:occurs_on],
#     Arel::Nodes::And.new(2.days.ago, Time.now)
#   ))
# )
# join = Arel::Nodes::OuterJoin.new(Schedule.arel_table, on)
# Shift.joins(join).where(active: true).to_sql

  def equality_condition
    Arel::Nodes::Equality.new(payment[:lease_id], lease[:id]).and(between_condition)
  end

  def between_condition
    payment_applicable_period.between(Date.yesterday..Date.today)
  end

  def lease
    Lease.arel_table
  end

  def payment
    Payment.arel_table
  end
end
