require 'date'

module Hotel
  class InvalidDateError < StandardError
  end

  class DateRange
    attr_reader :dates, :check_in, :check_out
    def initialize(check_in, check_out)
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @dates = Array(@check_in..@check_out)
      validate_dates
    end

    def validate_dates
      unless @check_in >= Date.today
        raise InvalidDateError.new("Check-in cannot be before today's date.")
      end
      unless @check_in < @check_out
        raise InvalidDateError.new("Check-in cannot be after check-out.")
      end
    end

    def make_date(date)
      if date.class != Date
        date = Date.parse(date)
      end
      return date
    end

    def validate_block_dates(check_in, check_out)
      check_in = make_date(check_in)
      check_out = make_date(check_out)
      if @check_in >= check_in && @check_out <= check_out
        return true
      else
        raise ArgumentError.new("Cannot reserve for those dates - dates must be the same as block dates.")
        return false
      end
    end

    def overlaps?(date)
      date = make_date(date)
      unless date >= @check_in && date < @check_out
        return false
      end
    end

  end
end
