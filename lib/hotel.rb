# hotel
require_relative 'room.rb'
require 'date'

module HotelManagment
  class Hotel
    attr_reader :rooms, :reservations
    def initialize
      @rooms = []
      @reservations = []
      @reserved_rooms = []
    end

    def add_20_rooms
      num = 1
      20.times do
        room = HotelManagment::Room.new(num,"available")
        @rooms << room
        num += 1
      end
    end


    def self.all_rooms
    end


    def create_reservation
      reservation = reservation.new(first_name, last_name, check_in_date,check_out_date)

      @reservations << reservation
    end


    def self.all_reservations
    end


  end #class end
end #module end
