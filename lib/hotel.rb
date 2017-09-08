require_relative 'date_range'

module Booking
  class Hotel
    attr_reader :list_of_rooms, :list_of_reservations

    def initialize
      @list_of_rooms = [*1..20]
      @list_of_reservations = []
    end


    #I can reserve an available room for a given date range
    def make_reservation(checkin, checkout, room_number)
      date_range = DateRange.new(checkin, checkout)
      all_available_rooms = list_of_rooms(date_range)
      if all_available_rooms.include?(room_number)
        reserve =  Reservation.new(checkin, checkout, room_number)
        list_of_reservations << reserve
      end
      return reserve
    end


    #returns list of reservations for specific date
    def list_of_reservations_for_a_date(date)
      found_reservations = []
      @list_of_reservations.each do |reserve|
        if reserve.date_range.is_included?(date)
          found_reservations << reserve
        end
      end
      return found_reservations
    end

    # Gives list of available rooms for a given date
    def list_of_rooms(date_range)
      available_rooms = Array.new(true, 21) # Setting all rooms to available

      @list_of_reservations.each do |r|
        if (date_range.overlaps?(r.date_range)) # if date_ranges intersect
          available_rooms[r.room_number] = false # the room at that index becomes unavailable
        end
      end

      result = []
      available_rooms.each_with_index do | is_available, i|
        if i != 0 && is_available
          result << i
        end
      end
      return result
    end
  end
end
