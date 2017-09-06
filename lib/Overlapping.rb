module Overlapping
  def overlapping?(start_date, end_date, comparison_start_date, comparison_end_date)
    # start date is within comparison date range
    return true if start_date >= comparison_start_date && start_date < comparison_end_date
    # end date is within comparison date range
    return true if end_date >= comparison_start_date && end_date <= comparison_end_date
    return false
  end
end
