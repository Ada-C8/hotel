# hotel
require_relative 'room.rb'
require 'date'

module HotelManagment
  class Hotel
    attr_reader :rooms, :reservations, :found_reservations, :unreserved_rooms
    def initialize
      @rooms = []
      @reservations = []
      @found_reservations = []
      @unreserved_rooms = []
    end

    def add_20_rooms
      room_number = 1
      20.times do
        room = HotelManagment::Room.new(room_number)
        @rooms << room
        room_number += 1
      end
    end


    def create_reservation(first_name, last_name, check_in_date,check_out_date, room_number)

      if check_in_date < DateTime.now || check_out_date < check_in_date
        raise ArgumentError, 'Invalid dates'
      end

      reservation = Reservation.new(first_name, last_name, check_in_date,check_out_date, room_number)
      @reservations << reservation
    end

    # ------------------------------------------------
    def reservations_by_date(date)
      @reservations.each { |reservation|
        if reservation.check_in_date <= date && reservation.check_out_date >= date
          found_reservations << reservation
        end
      }
      return @found_reservations
    end
    # ------------------------------------------------

    # TODO
    def rooms_not_reserved(begin_date, end_date)

      @reservations.each { |reservation|

        unless reservation.check_in_date >= begin_date && reservation.check_out_date <= end_date
          unreserved_rooms << reservation.room_number
        end
      }
      return @unreserved_rooms
    end

  end #class end
end #module end
