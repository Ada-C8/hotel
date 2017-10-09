require 'date'
require 'pry'
module Hotel
  class Reservations

    attr_reader :all_reservations, :all_rooms, :all_blocks, :rez, :collection_of_rooms_blocked

    def initialize
      @all_rooms = []
      create_rooms(@all_rooms)
      @all_reservations = []
      @all_blocks = []
      @all_rooms_in_block = []
      @list_of_rooms = []
      @collection_of_rooms_blocked = collection_of_rooms_blocked
    end

    def create_rooms(all_rooms)
      20.times do |i|
        num = i + 1
        all_rooms << Room.new(num)
      end
    end

    def make_booking(checkin, checkout, num_of_rooms = 1)
      # do we have an availability?
      availability = check_availability(checkin, checkout)
      if availability.length < num_of_rooms
        raise RoomAvailabilityError.new "Sorry, we don't have enough rooms. There are only #{availability.length} rooms left"
      end
      # if hotel has availabilities, Booking.new is created and pushed into @all_reservations
      id = @all_reservations.length
      rooms = availability.take num_of_rooms
      booking = Booking.new(checkin, checkout, rooms, id)
      @all_reservations << booking
      return booking
    end

    def print_reservations
      return @all_reservations
    end

    def check_reservations(checkin, checkout)
      check_against = DateRange.new(checkin, checkout).nights
      not_available = []
      check_against.each do |date|
        @all_reservations.each do |booking|
          if booking.dates.include?(date)
            booking.rooms.each do |room|
              not_available << room
            end
          end
        end
      end
      return not_available
    end

    def check_availability(checkin, checkout)
      # this is the inverse of not_available array
      # Jamie's note: Instead of calling check_reservations within the loop, call it once before and store the collection in a local variable to call .include? on.

      list_of_not_available = check_reservations(checkin, checkout)

      available = []
      @all_rooms.each do |room|
        unless list_of_not_available.include?(room)
          available << room
        end
      end
      return available
    end

    def make_block(checkin, checkout, collection_of_rooms_blocked, block_id)
      available = check_availability(checkin, checkout)
      if collection_of_rooms_blocked > 5
        raise BlockAvailabilityError.new "You cannot block more than 5 rooms."
      else
        #  collection_of_rooms_blocked = []
        collection_of_rooms_blocked.times do |i|
          @list_of_rooms << available[i]
        end
        new_block = Hotel::Block.new(checkin, checkout, collection_of_rooms_blocked, block_id)
        @all_blocks << new_block
        return new_block
      end
    end


    def reserve_room_from_block(block_id)
      # I think I need to try and subtract the collection_of_rooms_blocked each time a reservation is made...

      # Jamie's comment: This method is creating a new block in order to make the reservation, However, the method should work with an existing block of the @all_blocks collection. A reservation should only be made from an existing instance, otherwise the state won't persist to the next time reserve_room_from_block is called. It is also saving an instance of block to @all_reservations. @all_reservation should only hold instances of the Booking class. Otherwise other methods that depend on @all_reservations, like check_reservations, aren't going to run as expected. The idea isn't to reserve a whole block, but to reserve a room that happens to part of a block.

      if @collection_of_rooms_blocked == 0
        raise BlockAvailabilityError.new "There are no blocks available for your dates."
      end
      @all_blocks.each do  |block|
        unless block.check_block_for_availability(block_id) && block.check_block_id(block_id)
          rooms = @list_of_rooms
          # block.available_rooms.take
          rez = Booking.new(block.dates.checkin, block.dates.checkout, rooms, block.block_id)
          @all_reservations << rez
          #  @collection_of_rooms_blocked -= 1
          return rez
        else
          raise BlockAvailabilityError.new "Sorry, all of the rooms in the block have been booked."

        end
      end
    end
  end
end
