require 'date'

module Hotel
  class DateRange
    attr_reader :checkin_date, :checkout_date

    # Checkin and checkout dates are instances of the Date class
    def initialize(checkin_date, checkout_date)
      if !checkin_date.is_a?(Date) || !checkout_date.is_a?(Date)
        raise ArgumentError.new("Checkin or Checkout dates is not Date object")
      end

      if checkin_date > checkout_date
        raise ArgumentError.new("Checkin date must be before Checkout date")
      end

      @checkin_date = checkin_date
      @checkout_date = checkout_date
    end

    # check if reservation date request is within date range.
    def date_include?(date_range)
      # if date >= @checkin_date && date <= @checkout_date
      start_date = date_range.checkin_date
      end_date = date_range.checkout_date
      
      if start_date >= @checkin_date && end_date <= @checkout_date
        return true
      else
        return false
      end
    end

    # check if the room is overbooked
    def date_overlap?(date_range)
      #(@checkin_date - end_date) * (start_date - @checkout_date) >= 0
      # Will this method work?
      start_date = date_range.checkin_date
      end_date = date_range.checkout_date

      if (start_date <= @checkout_date) && (end_date > @checkin_date)
        return true
      else
        return false
        # raise ArgumentError.new("#{start_date} and #{end_date} are outside the date range")
      end
    end

  end #end of class
end #end of module


#### TESTING ##########

# checkin_date = 2001,2,3
# checkout_date = 2001,2,14
# date =  Hotel::DateRange.new(checkin_date, checkout_date)
# puts date.date_include?(2001,2,5)
