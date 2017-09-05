module Hotel
  class Room

    STANDARD_RATE = 200
    @@rooms = []

    def initialize(room_num)
      @room_num = room_num
      @rate = STANDARD_RATE
      @@rooms.push({room_num: @room_num, rate: @rate})
    end

    def self.all
      return @@rooms
    end

  end # Room class
end # Hotel module
