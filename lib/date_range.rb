module BookingSystem
  class DateRange
    attr_reader :check_in, :check_out

    def initialize(check_in, check_out)
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
    end

    def start_end
      # Populates all dates in between array
      all_dates = (@check_in..@check_out).map { |date| date }
      return all_dates
    end

    # def include?
    # end
    #
    # def overlap?
    # end

  end # DateRange
end # BookingSystem
