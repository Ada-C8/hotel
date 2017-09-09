require 'pry'

module HotelBooking
  class Block
    attr_accessor :id, :guest, :check_in, :check_out, :room_ids
    attr_reader :discounted_rate

    def initialize(check_in,check_out,room_ids,discounted_rate,block_id)
      @check_in = Date.parse(check_in) #ruby Date object
      @check_out = Date.parse(check_out) #ruby Date object
      @room_ids = room_ids
      @discounted_rate = discounted_rate
      # room_ids.each do |id|
      #   room = HotelBooking::Hotel.find_room_by_id(id)
      #   # room.reserve_room(check_in,check_out,@id)
      #   @rooms << room
      # end

      @id = block_id
    end

  end

end
