module Hotels
  class Room

    attr_reader :room_id, :price

    REGULAR_RATE = 200
    BLOCK_RATE = 150

    def initialize(room_number)
      @room_id = room_number
      @price = REGULAR_RATE
    end

  end
end
