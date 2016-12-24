module ApplicationHelper

  def rent_due_options
    {
      "1st day of the month": "1",
      "2nd day of the month": "2",
      "3rd day of the month": "3",
      "4th day of the month": "4",
      "5th day of the month": "5",
      "6th day of the month": "6"
    }
  end

  def month_options
    opt = (1..60).to_a
    opt.collect {|a| [pluralize(a, 'month'), a] }
  end

  def payment_method_options
    {
     "Mail-in Check": "mail_in_check",
     "Mail-in Money Order": "mail_in_money_order",
     "Main-in Cashier's check": "mail_in_cashier_check",
     "Internet Payment": "internet_payment",
     "Direct Deposit": "direct_deposit"
    }
  end

  def frequency_options
    {
      "Weekly": "weekly",
      "Monthly": "monthly",
      "Yearly": "yearly",
      "One Time": "one_time"
    }
  end
end
