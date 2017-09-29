require 'date'

module Hotel
  class DateRange
    attr_reader :start, :end, :check_in, :check_out
    def initialize(check_in, check_out)
      @start = check_in
      @end = check_out
      if (@end <= @start) || (Date.today > @start)
        raise ArgumentError.new("This is an invalid date range.")
      end
    end

    def nights
      @nights = (@end-@start)
      return @nights
    end

    def include?(date)
      if (self.start...self.end).include?(date)
        return true
      else
        return false
      end
    end


    def overlap?(check_in, check_out)
      if (self.start < check_out) && (check_in < self.end)
        true
      else
        false
      end
    end

  end
end
