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
end
