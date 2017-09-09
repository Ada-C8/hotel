require_relative 'reservation'
require_relative 'room'
require_relative 'reservable'

module Hotel

  class Block
    include Reservable

    MAX_ROOMS = 5

    attr_accessor :check_in, :check_out, :discount, :room_block

    def initialize(check_in, check_out, discount, room_block)
      # check input
      # TODO fix discount / rate in room and block
      raise ArgumentError.new("Can't have more than #{MAX_ROOMS} number of rooms in a block") if room_block.length > MAX_ROOMS

      raise ArgumentError.new("Can't have unavailable rooms in the block") if room_block.any? { |room| room.unavailable?(check_in, check_out) }

      raise ArgumentError.new("Not a discounted rate") if discount >= 1 || discount <= 0

      @check_in = check_in
      @check_out = check_out
      valid_dates?

      @discount = discount  # discount as decimal (e.g. 0.8 for 80% of orig rate)
      @room_block = room_block # array of rooms

      # add block to each room
      room_block.cycle(1) { |room| room.blocks << self }

    end

    def is_available?(room)
      raise ArgumentError.new("Room #{room.room_num} isn't in the block") if !room_block.include?(room)

      return !room.is_booked?(check_in, check_out)
    end

    def find_avail_in_block
      return room_block.select { |room| is_available?(room) }
    end

    def reserve(room)
      raise ArgumentError.new("Room #{room.room_num} isn't in the block") if !room_block.include?(room)

      raise ArgumentError.new("Room #{room.room_num} isn't available for the selected dates") if room.is_booked?(check_in, check_out)

      return room.reserve(check_in, check_out)
    end

    def discounted_cost(room)
      rate = room.rate * discount
      return total_cost(rate)
    end

  end # end of Block class

end
