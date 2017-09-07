module Hotels
  # Contains information regarding individual Rooms in Hotels::Hotel
  class Room
    attr_reader :room_name, :room_id

    # W1-C2 Every room is identical, and a room always costs $200/night
    REGULAR_RATE = 200
    BLOCK_RATE = 150

    def initialize(room_number)
      @room_name = "Room #{room_number}"
      @room_id = room_number
    end
  end
end
