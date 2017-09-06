require 'date'
require 'DateRange'

module Hotel
  class Booking
    def initialize(check_in, check_out) #room_rate, total_cost)

      @check_in = Date.new(check_in)
      @check_out = Date.new(check_out)
      #@date_range = date_range
      #@room_rate = room_rate
      @dates = DateRange.new(check_in, check_out)
      #@total_cost = total_cost
    end
  end

end
