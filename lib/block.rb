require 'date'
require_relative 'hotel.rb'
require_relative 'room.rb'
require_relative 'reservations.rb'

module Hotel_System

  class Block

    attr_accessor :array_of_room_objects, :check_in, :check_out, :today

    def initialize(num_of_rooms, check_in, check_out, discount)
      @num_of_rooms = num_of_rooms
      if @num_of_rooms > 5
        raise ArgumentError.new("Invalid block request -- too many rooms requested")
      end
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @today = Date.today
      @array_of_room_objects = []
    end

    def add_room_to_block(room_number)
      @array_of_room_objects << room_number
    end



    def valid_date_range?
      if @check_in < today
        raise ArgumentError.new("Invalid check in date")
      elsif check_out < today
        raise ArgumentError.new("Invalid check out date")
      elsif check_out < check_in
        raise ArgumentError.new("Invalid date range")
      elsif check_in == check_out
        raise ArgumentError.new("Check out must be after check in")
      else
        return true
      end
    end

  end
end
