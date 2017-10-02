
module HotelBooking
  class Block
    attr_accessor :id, :guest, :check_in, :check_out, :room_ids, :available_rooms
    attr_reader :discounted_rate

    def initialize(check_in,check_out,room_ids,discounted_rate,block_id)
      @check_in = check_in #ruby Date object
      @check_out = check_out #ruby Date object
      @room_ids = room_ids
      @available_rooms = room_ids.dup
      @discounted_rate = discounted_rate
      @id = block_id
    end

    def reserve_block_room(room_id)
      raise ArgumentError.new("This Block room is not available for this block reservation") if !(@available_rooms.include?(room_id))

      @available_rooms.delete(room_id)
    end


  end

end
