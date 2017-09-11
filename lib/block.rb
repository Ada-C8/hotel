require 'date'

module BookingSystem
  class Block
    attr_reader :reserved_for, :check_in, :check_out, :avail_block_rooms, :reserved_rooms, :block_total

    DISCOUNT_RATE = 150
    
    # To create a block you need a date range, collection of rooms and a discounted room rate
    def initialize(reserved_for, check_in, check_out, avail_block_rooms)
      dates = DateRange.new(check_in, check_out)
      @reserved_for = reserved_for
      @check_in = dates.check_in
      @check_out = dates.check_out
      @avail_block_rooms = avail_block_rooms # Blocked rooms is the reserved room numbers as an array
      @reserved_rooms = [] # Reserved rooms with room numbers as an Array
      @block_total = 0
    end

    def update_rooms_in_block(remaining_rooms, now_reserved_in_block)
      @avail_block_rooms = remaining_rooms
      @reserved_rooms = now_reserved_in_block
      calculate_block_total
    end

    private

    def calculate_block_total # Kept in a separate method in case more functionality needs to be added later on to update the rooms in the block
      @block_total = ((@check_out - @check_in) * DISCOUNT_RATE * @reserved_rooms.length).to_i
    end

  end # Block
end # BookingSystem
