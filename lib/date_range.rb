module DateRange
  require 'date'

  def self.range_to(start_date, end_date)
    start_date = validate(start_date)
    end_date = validate(end_date)
    validate_order(start_date, end_date)
    dates = []
    while start_date < end_date
      dates << start_date
      start_date += 1
    end
    dates
  end

  def self.overlap?(first_start, first_end, second_start, second_end)
    first_start = validate(first_start)
    first_end = validate(first_end)
    second_start = validate(second_start)
    second_end = validate(second_end)

    first_dates = DateRange.range_to(first_start, first_end)
    second_dates = DateRange.range_to(second_start, second_end)

    first_dates.each do |first_date|
      second_dates.each do |second_date|
        return true if first_date.strftime == second_date.strftime
      end
    end
    false
  end

  def self.include_all?(search_start, search_end, contain_start, contain_end)
    search_start = validate(search_start)
    search_end = validate(search_end)
    contain_start = validate(contain_start)
    contain_end = validate(contain_end)

    search_dates = DateRange.range_to(search_start, search_end)
    contain_dates = DateRange.range_to(contain_start, contain_end)

    search_dates.each do |search_date|
      return false unless contain_dates.include? search_date
    end
    true
  end

  def self.validate_order(first, second)
    first = validate(first)
    second = validate(second)
    unless first < second
      raise(DatesError, 'Start date must be at least 1 day before end date')
    end
    true
  end

  def self.validate(input)
    if input.class == Date
      return input
    elsif input.class == String
      return Date.parse(input)
    else
      raise(ArgumentError, "Input #{input.class} cannot be converted into Date")
    end
  end
end
