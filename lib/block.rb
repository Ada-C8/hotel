require 'date'

module Administration
  class Block

    DISCOUNT_RATE = 180

    attr_reader :check_in, :check_out, :rooms
    #
    def initialize(check_in, check_out, rooms)
      @check_in = check_in
      @check_out = check_out
      @rooms = Array.new(rooms) {|i| i+1}

      raise MaxNumRoomsError.new("Unable to block more than 5 rooms") if @rooms.length > 5
    end

# The collection of rooms should only include rooms that are available for the given date range
    def rooms_for_block(check_in, check_out)
      rooms = find_available_rooms(date)
      block_rooms = rooms.sample(num)
      return block_rooms
    end







  end #end of Block
end #end of Administration
