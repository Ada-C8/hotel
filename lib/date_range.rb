require 'date'

module Hotel

  class DateRange
    attr_reader :checkin, :checkout

# Checkin and checkout dates are instances of the Date class
    def initialize(checkin_date, checkout_date)
      @checkin_date = checkin_date
      # return checkin_date if  Date.valid_date?(checkin_date)
      @checkout_date = checkout_date
      # return checkout_date if Date.valid_date(checkout_date)
    end

# Check if date is included in date range
    def date_include?(date)
      if date >= @checkin_date && date <= @checkout_date
        return true
      else
        return false
        # raise ArgumentError.new("#{date} is an invalid date!")
      end
    end

  end #end of class
end #end of module


#### TESTING ##########

# checkin_date = 2001,2,3
# checkout_date = 2001,2,14
# date =  Hotel::DateRange.new(checkin_date, checkout_date)
# puts date.date_include?(2001,2,5)
