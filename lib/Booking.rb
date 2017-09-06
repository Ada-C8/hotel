require 'date'

module Hotel
  class Booking
    def initialize(check_in, check_out) #room_rate, total_cost)
      # @check_in_date = check_in_date
      # @check_out_date = check_out_date
      #@date_range = date_range
      #@room_rate = room_rate
      @dates = DateRange.new(check_in, check_out)
      @total_cost = total_cost
    end
  end

end
