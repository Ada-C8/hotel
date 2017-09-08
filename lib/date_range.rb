module DateRange
  require 'date'
  def self.range_to(start_date, end_date)
    find_range(start_date, end_date)
  end

  def self.range_with(start_date, end_date)
    find_range(start_date, end_date, :inclusive)
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

  # private

  def self.validate(input)
    return input if input.class == Date
    begin
      Date.parse(input)
    rescue
      raise(TypeError, "Invalid input #{input.class}-must be Date or String")
    end
  end

  def self.invalid_dates_error
    raise(InvalidDatesError, 'Start date must be before end date')
  end

  def self.find_range(start_date, end_date, flag = false)
    start_date = validate(start_date)
    end_date = validate(end_date)
    invalid_dates_error unless start_date < end_date
    dates = []
    while start_date < end_date
      dates << start_date
      start_date += 1
    end
    dates << end_date if flag == :inclusive
    dates
  end
end
