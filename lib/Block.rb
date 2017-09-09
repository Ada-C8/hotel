
module Hotel
  class Block
    attr_reader :check_in, :check_out, :date_range, :dates, :rooms_collection, :discounted_room_rate
    def initialize(check_in, check_out, rooms_collection, discounted_room_rate = 180)
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @date_range = Hotel::DateRange.new(@check_in, @check_out)
      @dates = Hotel::DateRange.new(@check_in, @check_out).dates
      @rooms_collection = rooms_collection
      @discounted_room_rate = discounted_room_rate

    end

    #def make_new_block



  end
end
