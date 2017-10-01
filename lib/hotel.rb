require_relative 'room'
require_relative 'reservation'
require_relative 'block'

module Hotel

  class Hotel
    include Reservable

    NUM_ROOMS = 20

    attr_reader :rooms

    def initialize(num_rooms = NUM_ROOMS)
      # check input
      check_room_num(num_rooms)

      @rooms = {}

      # loop through num_rooms and add rooms to hash
      (1..num_rooms).each do |num|
        @rooms[num] = ::Hotel::Room.new(num)
      end

    end

    def reserve(start_date, end_date, room_num)
      check_dates(start_date, end_date)
      room = @rooms[room_num]

      raise ArgumentError.new("Room #{room_num} isn't available for the selected dates") if room.booked?(start_date, end_date) || room.blocked?(start_date, end_date)

      return room.reserve(start_date, end_date)

    end

    def block(start_date, end_date, discount, room_nums)
      block_rooms = room_nums.map { |room_num| rooms[room_num] }

      raise ArgumentError.new("One or more rooms is unavailable for the selected dates") if block_rooms.any? { |room| room.booked?(start_date, end_date) || room.blocked?(start_date, end_date) }

      return ::Hotel::Block.new(start_date, end_date, discount, block_rooms)
    end

    def reserve_blocked_room(block, room_num = nil)
      # allows user to specify a room number; else system automatically
      # choose a room from the block
      avail_rooms = block.find_avail_in_block

      raise ArgumentError.new("No more rooms available in block") if avail_rooms.length < 1

      # assign room num if not provided
      room = room_num == nil ? avail_rooms.pop : rooms[room_num]

      # if room num provided, check if available
      if room_num && !block.room_available?(room)
        raise ArgumentError.new("Room #{room_num} is already booked")
      else
        block.reserve(room)
      end
    end

    def find_reservations_by_date(date)
      return ::Hotel::Reservation.find_by_date(date)
    end

    def find_avail_rooms(start_date, end_date)
      # returns a hash of rooms available in the date range

      # check input
      check_dates(start_date, end_date)

      return rooms.reject { |room_num, room| room.booked?(start_date, end_date) || room.blocked?(start_date, end_date) }

    end

  end # end of Hotel class

end
