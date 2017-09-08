module Hotel
  class Room

    attr_reader :room_num
    attr_accessor :rate

    STANDARD_RATE = 200
    @@rooms = []

    def initialize(room_num)
      @room_num = room_num
      @rate = STANDARD_RATE
      collect_instance
    end

    def collect_instance
      @@rooms.push(self)
    end

    def self.all
      return @@rooms
    end

    def self.update_price(room_num, new_rate)
      index = @@rooms.find_index { |i| i.room_num == room_num }
      @@rooms[index].rate = new_rate
    end

  end # Room class
end # Hotel module
