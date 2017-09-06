module Hotel
  class Room
    attr_reader :room_number, :room_rate

    def initialize(room_number, room_rate = 200)
      @room_number = room_number
      @room_rate = room_rate
    end

  end

end
