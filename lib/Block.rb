
module Hotel
  class Block
    attr_accessor :check_in, :check_out, :date_range, :dates, :block_rooms_collection, :discounted_room_rate, :available_rooms, :booked, :block_name
    def initialize(check_in, check_out, block_name, block_rooms_collection = [], discounted_room_rate = 180)
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @date_range = Hotel::DateRange.new(@check_in, @check_out)
      @dates = Hotel::DateRange.new(@check_in, @check_out).dates
      @block_rooms_collection = block_rooms_collection
      @discounted_room_rate = discounted_room_rate
      @booked = []
      @block_name = block_name
      #@available_rooms = @block_rooms_collection
    end

    def has_rooms_available?
      if @booked.length < @block_rooms_collection.length
        return true
      else
        return false
      end
    end



  end
end
