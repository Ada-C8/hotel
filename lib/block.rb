module Hotel
  class Block
    attr_reader :block_id, :block_rooms, :date_range
    def initialize(block_id, block_rooms, date_range)
      @block_id = block_id.upcase
      @block_rooms = block_rooms
      @date_range = date_range
    end # initialize
  end # Block
end # Hotel
