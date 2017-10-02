require_relative 'room'
require_relative 'reservation'
require_relative 'date_range'
require 'date'


module Hotel
  class BookingSystem
    attr_reader :collection_of_rooms, :collection_of_reservations, :block_rooms

    #Access list of all rooms in the hotel.
    def initialize
      @collection_of_reservations = []
      @collection_of_rooms = []
      @block_rooms = []
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
    #
    # def make_block_rooms(date_range, num_rooms)
    #
    #     end
    #   end
    #   # take in the num_rooms to determine # iteration
    #   # loop through the collection_of_rooms to find the first available rooms that match criteria
    #   # if you find the num_rooms before looping through entire array, break; if not continue
    # end


    def print_reservations(date_range)
      reservation_list = []
      @collection_of_reservations.each do |reservation|
        if reservation.date_range.date_include?(date_range)
          # refactor: create new method for reservation date range in reservation class and call it in print reservation.
          reservation_list << reservation
        end
      end
      return reservation_list
    end

    def room_available(room_number, res_date)
      room_is_available = true

      @collection_of_reservations.each do |reservation|
        reserved_rooms = reservation.reserved_rooms
        # overlap = reservation.date_range.date_overlap?(date_range) #initial design
        if !reservation.overlap(res_date) # new design
          # # refactor
          # puts reserved_rooms.class
          reserved_rooms.each do |room|
            puts room.room_num
            if room.room_num == room_number && overlap == true
              room_is_available = false
            end
          end
        else
          return false
        end
      end

      # if room_is_available
      #   @block_rooms.each do |block|
      #     block.include room.room_num
      #     room_is_available = false
        # if the room is in a block for that date range, room_is_available = false
      # end

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

#TESTING#####
# new_reservation = Hotel::BookingSystem.new
# # puts new_reservation.collection_of_rooms
# checkin_date = Date.new(2001,01,01)
# checkout_date = Date.new(2001,01,31)
# dates = Hotel::DateRange.new(checkin_date, checkout_date)
# puts new_reservation.make_reservation("bob", 1, dates)
# puts
# puts new_reservation.collection_of_reservations
# #
# trey = new_reservation.make_reservation("trey", 2, dates)
# puts trey.total_cost
# puts "this is the total cost"
# new_reservation.collection_of_reservations


#TESTING FOR AVAILABILITY
# puts new_reservation.room_available(1)
# puts new_reservation.room_available(9)
# checkin_date = Date.new(2001,01,05)
# checkout_date = Date.new(2001,01,14)
# dates = Hotel::DateRange.new(checkin_date, checkout_date)
# new_reservation.make_reservation("trey", 2, dates)
# puts new_reservation.print_reservations(dates)
# checkin_date = Date.new(2001,01,30)
# checkout_date = Date.new(2001,02,2)
# dates = Hotel::DateRange.new(checkin_date, checkout_date)
# new_reservation.make_reservation("suyi", 3, dates)

# puts
# puts
##TESTING FOR OVERLAP
# checkin_date = Date.new(2001,02,2)
# checkout_date = Date.new(2001,02,10)
# dates = Hotel::DateRange.new(checkin_date, checkout_date)
# puts
# puts new_reservation.room_available(1,dates)
# puts new_reservation.make_reservation("bob", 1, dates)
# puts new_reservation.collection_of_reservations
#
#
# checkin_date = Date.new(2001,02,3)
# checkout_date = Date.new(2001,02,7)
# dates = Hotel::DateRange.new(checkin_date, checkout_date)
# puts new_reservation.room_available(1,dates)
# #
# checkin_date = Date.new(2001,02,3)
# checkout_date = Date.new(2001,02,14)
# dates = Hotel::DateRange.new(checkin_date, checkout_date)
# puts new_reservation.room_available(1,dates)
# puts
# checkin_date = Date.new(2001,01,3)
# checkout_date = Date.new(2001,01,7)
# dates = Hotel::DateRange.new(checkin_date, checkout_date)
# puts new_reservation.room_available(1,dates)
# puts
# puts
#
# checkin_date = Date.new(2017,01,3)
# checkout_date = Date.new(2017,01,7)
# dates = Hotel::DateRange.new(checkin_date, checkout_date)
#
# rooms = [2,3,4,5,6]

# puts new_reservation.reserve_block_rooms(dates, rooms)
