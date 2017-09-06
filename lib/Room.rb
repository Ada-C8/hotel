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
      @@rooms.each do |room|
        room.rate = new_rate if room.room_num == room_num
      end
    end

  end # Room class
end # Hotel module
