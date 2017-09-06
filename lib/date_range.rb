
require 'date'
module Booking
  class DateRange
    attr_reader :checkin, :checkout

    def initialize(checkin, checkout)
      @checkin = checkin
      @checkout = checkout
    end

    def is_included?(date)
      if date >= @checkin && date < @checkout
        return true
      else
        return false
      end
    end


    def number_of_nights
      return (@checkout - 1) - @checkin
    end
  end
end
