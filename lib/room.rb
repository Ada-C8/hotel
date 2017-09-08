require 'date'

module Hotel
  class Room
    attr_reader :room_num, :room_rate

    def initialize(room_num)
      @room_num = room_num
      @room_rate = 200
    end

    # Get all the room objects
    def self.all
      rooms = []
      20.times do |i|
        rooms << Hotel::Room.new(i + 1)
      end
      return rooms
    end
  end # end of class

end # end of module


#####TESTING#######
# room = Hotel::Room.all?
# puts room
