require 'date'
require 'DateRange'

module Hotel
  class Booking
    attr_reader :check_in, :check_out, :room_number
    def initialize(check_in, check_out, room_number = rand(1..20)) #room_rate, total_cost)
      @room_number = room_number
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      #@date_range = date_range
      #@room_rate = room_rate
      @dates = DateRange.new(check_in, check_out)
      @total_cost = total_cost
    end
    
  end

end
