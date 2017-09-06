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
