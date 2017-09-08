module Overlapping
  def overlapping?(start_date, end_date, comparison_start_date, comparison_end_date)
    return true if start_date_overlaps?(start_date, comparison_start_date, comparison_end_date)
    return true if end_date_overlaps?(end_date, comparison_start_date, comparison_end_date)
    return true if fully_overlaps?(start_date, end_date, comparison_start_date, comparison_end_date)
    return false
  end

  def start_date_overlaps?(start_date, comparison_start_date, comparison_end_date)
    start_date >= comparison_start_date && start_date < comparison_end_date
  end

  def end_date_overlaps?(end_date, comparison_start_date, comparison_end_date)
    end_date >= comparison_start_date && end_date <= comparison_end_date
  end

  def fully_overlaps?(start_date, end_date, comparison_start_date, comparison_end_date)
    return true if start_date <= comparison_start_date && end_date >= comparison_end_date
  end
end
