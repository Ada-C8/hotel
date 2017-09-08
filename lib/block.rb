module BookingSystem
  class Block
    attr_reader :check_in, :check_out, :blocked_rooms, :block_total

    DISCOUNT_RATE = 150

    def initialize(check_in, check_out, blocked_rooms)
      @check_in = check_in
      @check_out = check_out
      @blocked_rooms = blocked_rooms # Number of rooms as room numbers
      @block_total = 0
    end

  end # Block
end # BookingSystem

# Block booking is a one reservation with 5 rooms
# total = check_out - check_in * 150 * block_rooms.length
# Reserve a room in a block as a method

# As an administrator, I can create a block of rooms
# To create a block you need a date range, collection of rooms and a discounted room rate
# The collection of rooms should only include rooms that are available for the given date range
# If a room is set aside in a block, it is not available for reservation by the general public, nor can it be included in another block
