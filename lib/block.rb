module BookingSystem
  class Block
    attr_reader :reserved_for, :check_in, :check_out, :avail_block_rooms, :block_total, :avail_block_rooms, :reserved_rooms

    DISCOUNT_RATE = 150

    def initialize(reserved_for, check_in, check_out, avail_block_rooms)
      dates = DateRange.new(check_in, check_out)
      @reserved_for = reserved_for
      @check_in = dates.check_in
      @check_out = dates.check_out
      @avail_block_rooms = avail_block_rooms # Blocked rooms is the reserved room numbers as an array
      @reserved_rooms = [] # Reserved rooms with room numbers as an Array
      @block_total = 0
    end

    def reserve_block_cost
      @block_total = ((@check_out - @check_in) * DISCOUNT_RATE * @reserved_rooms.length).to_i
      return @block_total
    end

    def update_block_rooms(remaining_rooms, now_reserved_in_block)
      @avail_block_rooms = remaining_rooms
      @reserved_rooms = now_reserved_in_block
    end

  end # Block
end # BookingSystem



# Reserve block returns that instance of a block. Now what do i do?

# It doesn't matter if the block is hidden from the public now we have to call the method from within the block instance
# As an administrator, I can check whether a given block has any rooms available
# As an administrator, I can reserve a room from within a block of rooms


# As an administrator, I can create a block of rooms
# To create a block you need a date range, collection of rooms and a discounted room rate
# The collection of rooms should only include rooms that are available for the given date range
# If a room is set aside in a block, it is not available for reservation by the general public, nor can it be included in another block
