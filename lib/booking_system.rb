require_relative 'room'
require_relative 'reservation'
require_relative 'date_range'
require 'date'


module Hotel
  class BookingSystem
    attr_reader :collection_of_rooms, :collection_of_reservations

    #Access list of all rooms in the hotel.
    def initialize
      @collection_of_reservations = []
      @collection_of_rooms = []
      build_rooms
      # is it better to create a separate method and call in initialize?
      # 20.times do |i|
      #   room = Hotel::Room.new(i + 1, 200)
      #   @collection_of_rooms << room
      # end
    end

    def build_rooms
      20.times do |i|
        room = Hotel::Room.new(i + 1, 200)
        @collection_of_rooms << room
      end
    end

    def print_reservations(date_range)
      reservation_list = []
      @collection_of_reservations.each do |reservation|
        if reservation.date_range.date_include?(date_range)
          reservation_list << reservation
        end
      end
      return reservation_list
    end

    def room_available(room_number, date_range)
      room_is_available = true

      @collection_of_reservations.each do |reservation|
        reserved_rooms = reservation.reserved_rooms
        overlap = reservation.date_range.date_overlap?(date_range)

        # puts reserved_rooms.class
        reserved_rooms.each do |room|
          puts room.room_num
          if room.room_num == room_number && overlap == true
            room_is_available = false
          end
        end
      end
      return room_is_available
    end

    def make_reservation(name,room_num,date_range)
      reserved_rooms = []

      if room_available(room_num,date_range) == true

        reserved_rooms << @collection_of_rooms[room_num - 1]
        reservation = Hotel::Reservation.new(name,reserved_rooms,date_range)
        @collection_of_reservations << reservation
      else
        raise ArgumentError.new("Room unavailable")
      end
      return reservation
    end

  end #end of class
end # end of module

