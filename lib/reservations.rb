require 'date'

module Hotel
  class RoomQuantityError < StandardError
  end

  class Reservations
    attr_reader :all_rooms, :all_reservations

    def initialize
      @all_rooms = []
      create_rooms

      @all_reservations = []


    end

    def create_rooms
      20.times do |i|
        num = i + 1
        @all_rooms << Room.new(num)
      end
    end


    def make_booking(no_of_rooms, start_date, end_date, block: false)

      date_range = DateRange.new(start_date, end_date)

      availability = check_availability(start_date, end_date)
      check_if_enough(availability, no_of_rooms)

      id = (@all_reservations.length + 1)

      rooms = create_rooms_for_booking(no_of_rooms, availability, block)

      if block == true
        check_number_for_block(no_of_rooms)
        block_id = id
        booking = Block.new(id, rooms, date_range, block_id)
      else
        booking = Booking.new(id, rooms, date_range)
      end

      @all_reservations << booking
      return booking
    end

    def create_rooms_for_booking(no_of_rooms, availability, block)
      rooms = []
      no_of_rooms.times do |i|
        room = availability[i]
        if block == true
          room.reserved = false
        else
          room.reserved = true
        end
        rooms << room
      end
      return rooms
    end

    # Toggling reserved here doesn't take the dates into account. I suspect this means you will run into trouble if you have multiple blocks containing the same rooms for different dates.
    # Instead, each block should probably keep track of which rooms are reserved and which are still available.

    def check_number_for_block(no_of_rooms)
      if no_of_rooms > 5
        raise RoomQuantityError.new("Blocks can have a maximum of 5 rooms")
      end
    end

    def check_if_enough(availability, no_of_rooms)
      if availability.length < no_of_rooms
        raise RoomQuantityError.new "not enough rooms available for that date."
      end
    end
    # This loop ends up being pretty complex. What if, similar to the way you've defined DateRange#include?, you wrote a DateRange#overlap?(start_date, end_date)? It seems like a similar delegation of responsibility, and would greatly simplify this loop.
    # If you combined that with the suggestion below, the method would look like this:

    # def check_reserved(start_date, end_date, room)
    #   return @all_reservations.any? do |booking|
    #     booking.room == room && booking.overlap?(start_date, end_date)
    #   end
    # end

    def check_reserved(start_date, end_date)
      check_against = DateRange.new(start_date, end_date).nights_arr

      not_available_reservations = @all_reservations.any? do |booking|
        booking.date_range.overlap?(check_against)
      end

      not_available = []
      not_available_reservations.each do |booking|
        booking.rooms.each do |room|
          not_available << room
        end
      end
      return not_available
    end

    def check_availability(start_date, end_date)
      available = []
      @all_rooms.each do |room|
        if check_reserved(start_date, end_date).include?(room) == false
          available << room
        end
      end
      return available
    end
    # Since this is the only place you use check_reserved, why not make it take a room number in addition to checkin/checkout dates? It could return a boolean and further simplify this conditional.

    # def check_reserved(start_date, end_date)
    #   check_against = DateRange.new(start_date, end_date).nights_arr
    #
    #   not_available = []
    #   check_against.each do |date|
    #     @all_reservations.each do |booking|
    #       if booking.date_range.include?(date)
    #         booking.rooms.each do |room|
    #           not_available << room
    #         end
    #       end
    #     end
    #   end
    #   return not_available
    # end


    def reserve_block_room(block, num)
      if num > block.rooms_available.length
        raise RoomQuantityError.new "Not enough rooms in block."
      end

      rooms_to_reserve = []
      num.times do |i|
        block.rooms[i].reserved = true
        rooms_to_reserve << block.rooms[i]
      end
      # This is an example of tight coupling. Instead of directly manipulating the block's data, it might be cleaner to write a method Block#reserve_rooms that does the work. That way, if the implementation of Block changes, this code will not have to change.
      res_id = @all_reservations.length + 1

      booking = Booking.new(res_id, rooms_to_reserve, block.date_range, block_id: block.block_id)

      @all_reservations << booking
      #but then how do I get a res_id and push to all_reservations?
      return booking
    end



  end
end
