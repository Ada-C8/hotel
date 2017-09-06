require 'date'
require_relative 'room.rb'
require_relative 'reservations.rb'

module Hotel_System

  class Hotel

    attr_reader :all_rooms, :room_list, :list_of_rooms, :room_number, :room_object, :room_price

    attr_accessor :all_reservations

    def initialize(num_of_rooms)
      @all_rooms = fill_hotel(num_of_rooms)
      @all_reservations = []
    end

    def return_room_object_by_num(room_number)
      room_object = @all_rooms[room_number - 1]
    end

    def list_of_rooms
      room_list = []
      @all_rooms.each do |room|
        room_list << room.room_number
      end
      return room_list
    end

    def total_cost(reservation)
    total_cost = reservation.num_of_nights * room.price

    end

    private

    def fill_hotel(num_of_rooms)
      room_array = []
      num_of_rooms.times do |i|
        room_array << Room.new(i + 1, 200)
      end
      return room_array
    end

  end

end
