require_relative '../lib/date_range'
module Booking
  class Reservation
    attr_reader :date_range, :room_number, :rate

    def initialize(date_range, room_number, rate = 200)
      @date_range = date_range
      @room_number = room_number
      @rate = rate
    end


    def total_cost
      return @date_range.number_of_nights * rate
    end

    def is_date_included?(date)
      return date_range.is_included?(date)
    end

    def does_reservation_overlap?(requested_date_range)
      return date_range.overlaps?(requested_date_range)
    end

  end
end
