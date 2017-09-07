require_relative 'date_range'
module Booking
  class Hotel
    attr_reader :list_of_rooms, :list_of_reservations

    def initialize
      @list_of_rooms = [*1..20]
      @list_of_reservations = []
    end

    def make_reservation(checkin, checkout, room_number)
      # date_range = DateRange.new(checkin, checkout)
      # room_number.available?
      reserve =  Reservation.new(checkin, checkout, room_number)
      list_of_reservations << reserve
      return reserve
    end


    def list_of_reservations_for_a_date(date)
      #returns list of reservations for specific date
      found_reservations = []
      @list_of_reservations.each do |reserve|
        if reserve.date_range.is_included?(date)
          found_reservations << reserve
        end
      end
      return found_reservations
    end

    # def available?(date)
    #   # check room availability for the given date and return list of available rooms
    # end

  end
end
