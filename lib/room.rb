module Hotels
  # Contains information regarding individual Rooms in Hotels::Hotel
  class Room
    attr_reader :room_name, :room_id
    REGULAR_RATE = 200
    BLOCK_RATE = 100

    def initialize(room_number)
      @room_name = "Room #{room_number}"
      @room_id = room_number
    end
  end
end
