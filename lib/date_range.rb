module DateRange
  require 'date'
  def self.range_to(start_date, end_date)
    start_date = validate(start_date)
    end_date = validate(end_date)
    raise(ArgumentError, 'Start date must be before end date') unless start_date < end_date
    dates = []
    while start_date < end_date
      dates << start_date
      start_date += 1
    end
    dates
  end

  def self.range_with(start_date, end_date)
    start_date = validate(start_date)
    end_date = validate(end_date)
    raise(ArgumentError, 'Start date must be before end date') unless start_date < end_date
    dates = []
    while start_date <= end_date
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

  # private

  def self.validate(input)
    return input if input.class == Date
    begin
      Date.parse(input)
    rescue
      raise(TypeError, "Invalid input #{input.class}-must be Date or String")
    end
  end
end
