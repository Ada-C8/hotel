require_relative '../lib/date_range'
module Booking
  class Reservation
    attr_reader :date_range, :room_number, :rate

    def initialize(checkin, checkout, room_number, rate = 200)
      @date_range = DateRange.new(checkin, checkout)#date_range
      @room_number = room_number
      @rate = rate
    end


    def total_cost
      return @date_range.number_of_nights * rate
    end



  end
end
