module Hotels
  # Contains information regarding individual Rooms in Hotels::Hotel
  class Room
    attr_reader :room_id, :price

    REGULAR_RATE = 200
    BLOCK_RATE = 150

    def initialize(room_number)
      @room_id = room_number
    end
  end
end
