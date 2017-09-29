require_relative 'block'

require 'date'

module Hotel
  class Hotel
    attr_reader :rooms

    def initialize
      # array of rooms
      @rooms = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
      # array of reservations
      @reservations = []
      #array of blocks
      @blocks = []
    end

    # reserves an available room (i.e., room that is not blocked or reserved)
    # for a given date range
    def create_reservation(name, room, check_in, check_out)
      if availability(check_in, check_out).include?(room)
        new_reservation = Reservation.new(name, room, check_in, check_out)
        @reservations << new_reservation
        return new_reservation
      else
        raise ArgumentError.new("That room is not available")
      end
    end

    # creates a block for a given date range if rooms are available (i.e., rooms in date range that are not blocked or reserved)
    def create_block(name, rooms, check_in, check_out, price_night)
      rooms.each do |room|
        unless availability(check_in, check_out).include?(room)
          raise ArgumentError.new("These rooms are not available as a block")
        end
      end
      new_block = Block.new(name, rooms, check_in, check_out, price_night)
      @blocks << new_block
      return new_block
    end


    def all_reservations
      return @reservations
    end

    def all_blocks
      return @blocks
    end

    def get_reservations_for_date(date)
      reservations_for_day = []
      all_reservations.each do |reservation|
        if reservation.dates.include?(date)
          reservations_for_day << reservation
        end
      end
      return reservations_for_day
    end


    # check availability of rooms for a certain date range
    def availability(check_in, check_out)
      reserved_rooms = []
      blocked_rooms = []
      date_range = DateRange.new(check_in, check_out)
      @reservations.each do |reservation|
        if date_range.overlap?(reservation.dates.start, reservation.dates.end)
          reserved_rooms << reservation.room
        end
      end

      @blocks.each do |block|
        if date_range.overlap?(block.dates.start, block.dates.end)
          block.rooms.each do |room|
            blocked_rooms << room
          end
        end
      end

      available_rooms = @rooms - reserved_rooms - blocked_rooms
      return available_rooms
    end

    # reserve a room from within a block of rooms
    def reserve_block_room(block)
      room = block.reserve_room
      reservation = Reservation.new(block.name, room, block.dates.start, block.dates.end)
      return reservation
    end

  end
end
