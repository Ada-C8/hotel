
module Hotel
  class DateRange
    attr_reader :checkin, :checkout

    def initialize(day1, day2)
      @checkin = day1
      @checkout = day2
      valid_date?
    end

    def valid_date?
      if @checkin < @checkout
        true
      else
        raise ArgumentError.new("No valid input")
      end
    end

    def stay_length
      (@checkout - @checkin).to_i
    end

    def include?(date)
      if @checkin <= date && @checkout > date
        return true
      else
        return false
      end
    end

  end
end #module
