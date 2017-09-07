# hotel
require_relative 'room.rb'
require 'date'

module HotelManagment
  class Hotel
    attr_reader :rooms, :reservations
    def initialize
      @rooms = []
      @reserved_rooms = []
      @reservations = []
    end

    def add_20_rooms
      num = 1
      20.times do
        room = HotelManagment::Room.new(num,"available")
        @rooms << room
        num += 1
      end
    end


    def create_reservation
      reservation = reservation.new(first_name, last_name, check_in_date,check_out_date, reservation_number, room_number)
      @reservations << reservation
    end


    def reservations_by_day_range
    end

    # def self.all_reservations
    # end

    # def self.all_rooms
    # end



  end #class end
end #module end
