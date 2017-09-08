module BookingSystem
  class DateRange

    class DateRangeError < StandardError
    end

    attr_reader :check_in, :check_out

    def initialize(check_in, check_out)

      unless check_in < check_out
        raise DateRangeError.new("Date range error: #{check_in} and #{check_out} is not a valid date range")
      end

      @check_in = check_in
      @check_out = check_out
    end

    def all_reservation_dates
      all_reservation_dates = (@check_in...@check_out).map do |date|
        date
      end
      return all_reservation_dates
    end

  end
end
