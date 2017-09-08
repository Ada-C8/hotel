module BookingSystem
  class Block
    attr_reader :reserved_for, :check_in, :check_out, :avail_block_rooms, :block_total, :avail_block_rooms

    DISCOUNT_RATE = 150

    def initialize(reserved_for, check_in, check_out, avail_block_rooms)
      dates = DateRange.new(check_in, check_out)
      @reserved_for = reserved_for
      @check_in = dates.check_in
      @check_out = dates.check_out
      @avail_block_rooms = avail_block_rooms # Blocked rooms is the reserved room numbers as an array
      @block_total = 0
      @booked_rooms_in_block = []
    end

  end # Block
end # BookingSystem

# Block booking is a one reservation with 5 rooms
# total = check_out - check_in * 150 * block_rooms.length
# Reserve a room in a block!!!!!
# Check to see what rooms within the block are available

# Reserve block returns that instance of a block. Now what do i do?

# It doesn't matter if the block is hidden from the public now we have to call the method from within the block instance
# As an administrator, I can check whether a given block has any rooms available
# As an administrator, I can reserve a room from within a block of rooms


# As an administrator, I can create a block of rooms
# To create a block you need a date range, collection of rooms and a discounted room rate
# The collection of rooms should only include rooms that are available for the given date range
# If a room is set aside in a block, it is not available for reservation by the general public, nor can it be included in another block
