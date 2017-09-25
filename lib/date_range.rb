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

    def number_of_nights
      return @check_out - @check_in
    end

    def overlap?(other_date_range_ob)
      return !(other_date_range_ob.check_in >= @check_out || other_date_range_ob.check_out <= @check_in)
    end

  end
end
