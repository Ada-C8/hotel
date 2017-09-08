require 'pry'

require_relative 'Booking'

module Hotel
  class Block < Hotel::Reservation #or is it Reservation
    attr_accessor :id, :guest, :check_in, :check_out, :rooms
    attr_reader :discounted_rate

    def initialize(check_in,check_out,room_ids,discounted_rate,block_id)
      @check_in = Date.parse(check_in) #ruby Date object
      @check_out = Date.parse(check_out) #ruby Date object
      @totalcost = discounted_rate
      @rooms = []
      @discounted_rate = discounted_rate
      room_ids.each do |id|
        room = Hotel::Room.find_by_id(id)
        # room.reserve_room(check_in,check_out,@id)
        @rooms << room
      end

      @id = block_id
    end

    def cost
     num_nights_charged * @discounted_rate
    end

  end

end
