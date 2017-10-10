# Room logic.  SIMPLE
# I need this to provide me with 20 numbered rooms starting at the number 1 and ending at the number 20.
# This also needs to (I believe) hold the room cost.  Each room has a $200 charge per night.

module HotelHedwig
  class Rooms

    attr_reader :room_num, :room_rate

# Initialize variables to access the room number AND the charge per room.  I believe this will make it easier to calculate in the end.

    def initialize(room_num)
      @room_num = room_num
      @room_rate = 200
    end

# Using a self.all method to work out the room numbering system.

    def self.all
      rooms = []
      room_num = 0
      20.times do
        number += 1
        rooms << self.new(room_num)
      end
    end
  end
end
