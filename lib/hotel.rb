require 'date'
require_relative 'room.rb'
require_relative 'reservations.rb'

module Hotel_System

  class Hotel

    attr_reader :all_rooms, :list_of_rooms, :room_number

    attr_accessor :all_reservations

    def initialize(num_of_rooms)
      @all_rooms = fill_hotel(num_of_rooms)
    end

    def room_number(index)
      room_number = @all_rooms[index].room_num
      return room_number
    end

    def list_of_rooms
      room_list = []
      @all_rooms.length.times do |i|
        room_list << room_number(i)
      end
      return room_list
    end

    def all_reservations
      @all_reservations = []

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
