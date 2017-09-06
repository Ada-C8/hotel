require_relative '../lib/date_range'
module Booking
  class Reservation
    attr_reader :date_range
    COST = 200

    def initialize(checkin, checkout, room_number)
      @date_range = DateRange.new(checkin, checkout)#date_range
      @room_number = room_number


    end

    def total_cost
      return @date_range.number_of_nights * COST
    end

  end
end
