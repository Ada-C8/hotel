# hotel
require_relative 'room.rb'
require 'date'

module HotelManagment
  class Hotel
    attr_reader :rooms, :reservations, :rate
    def initialize
      @rooms = []
      @reservations = []
    end

    def add_20_rooms
      room_number = 1
      20.times do
        room = HotelManagment::Room.new(room_number, rate)
        @rooms << room
        room_number += 1
      end
    end


    def create_reservation
      reservation = reservation.new(first_name, last_name, check_in_date,check_out_date, room_number)
      @reservations << reservation
    end

# ------------------------------------------------
    # def reservations_by_date(date)
    #   found_reservations = Array.new
    #   @reservations.each { |reservation|
    #     if (reservation.check_in_date <= date && reservation.check_out_date >= date)
    #       found_reservations.push(reservation)
    #     end
    #   }
    #   return found_reservations
    # end
# ------------------------------------------------



  end #class end
end #module end
