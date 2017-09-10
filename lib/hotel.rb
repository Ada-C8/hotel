# hotel
require_relative 'room.rb'
require 'date'

module HotelManagment
  class Hotel
    attr_reader :rooms, :reservations, :found_reservations, :unreserved_rooms, :blocks
    def initialize
      @rooms = []
      @reservations = []
      @found_reservations = []
      @unreserved_rooms = []
      @blocks = []
    end

    def add_20_rooms
      room_number = 1
      20.times do
        room = HotelManagment::Room.new(room_number)
        @rooms << room
        room_number += 1
      end
    end


    # creates a reservation
    def create_reservation(first_name, last_name, check_in_date, check_out_date, room_number)

      if check_in_date < DateTime.now || check_out_date < check_in_date
        raise ArgumentError, 'Invalid dates'
      end

      reservation = Reservation.new(first_name, last_name, check_in_date, check_out_date, room_number)

      @reservations << reservation
    end



    def reservations_by_date(date)
      @reservations.each { |reservation|
        if reservation.check_in_date <= date && reservation.check_out_date >= date
          found_reservations << reservation
        end
      }
      return @found_reservations
    end



    # returns an array or rooms not reserved for a given date range
    def rooms_not_reserved(check_in_date, check_out_date)
      # guard clause: if the reservations array is empty, return a rooms array of room numbers. If no reservations, all rooms can be reserved for a block.
      return @rooms.map { |room| room.room_number } if @reservations.empty?

      @reservations.each { |reservation|
        unless reservation.check_in_date >= check_in_date && reservation.check_out_date <= check_out_date
          # used local variable for unreserved_rooms
          unreserved_rooms << reservation.room_number
        end
      }
      return unreserved_rooms
    end


    # reserves the first available room for a given date range. Uses the rooms_not reserved method.
    def reserve_room_for_date_range(first_name, last_name, check_in_date, check_out_date)

      # set the rooms_not_reserved method and arguments to a local variable.
      # rooms_not_reserved returns an empty array if there is nothing avail in given date range.
      # or returns array of room numbers of the avail rooms in date range given.

      rooms_unreserved_for_this_date = rooms_not_reserved(check_in_date, check_out_date)

      if rooms_unreserved_for_this_date.length == 0
        raise ArgumentError, 'No Available Rooms for Given Dates'
      else
        create_reservation(first_name, last_name, check_in_date, check_out_date, rooms_unreserved_for_this_date[0])
      end
    end


    def create_block(check_in_date, check_out_date, amount_of_rooms)
      available_rooms = rooms_not_reserved(check_in_date, check_out_date)

      if available_rooms.length >= amount_of_rooms && amount_of_rooms <= 5
        block = HotelManagment::Block.new(check_in_date, check_out_date, amount_of_rooms)
        @blocks << block
      else
        # raise error
      end
      return @blocks
    end

  end #class end
end #module end
