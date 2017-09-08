require_relative 'hotel'

module ReservationSystem
  class Block
    include Reservable

    BLOCK_ROOM_LIMIT = 5

    attr_reader :rooms, :block_rate

    def initialize(start_date, nights, rooms_list, block_rate)
      @rooms = rooms_list
      @dates_blocked = date_range(start_date, nights)
      @block_rate = block_rate

      if @rooms.length > BLOCK_ROOM_LIMIT
        raise RoomLimit.new("Blocks may only contain #{BLOCK_ROOM_LIMIT} rooms. Your block will include only rooms #{@rooms.to_s}")
      end

      rooms_list.each do |room|
        room.blocked_nights += @dates_blocked
        room.rate = block_rate
      end
    end # initialize

  end #Block class
end #module
