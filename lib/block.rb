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

    def update_block_rooms(remaining_rooms, now_reserved_in_block)
      @avail_block_rooms = remaining_rooms
      @reserved_rooms = now_reserved_in_block
      reserve_block_cost
    end

    private

    def reserve_block_cost
      @block_total = ((@check_out - @check_in) * DISCOUNT_RATE * @reserved_rooms.length).to_i
    end

  end # Block
end # BookingSystem
