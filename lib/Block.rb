
module HotelBooking
  class Block
    attr_accessor :id, :guest, :check_in, :check_out, :room_ids
    attr_reader :discounted_rate

    def initialize(check_in,check_out,room_ids,discounted_rate,block_id)
      @check_in = check_in #ruby Date object
      @check_out = check_out #ruby Date object
      @room_ids = room_ids
      @discounted_rate = discounted_rate
      @id = block_id
    end

  end

end
