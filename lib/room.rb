require 'date'

module Hotel
  class Room
    ROOMS = (1..20).to_a
    attr_reader :room_number

    def initialize(room_number)
      @room_number = ROOMS[room_number-1]
    end # end #initialize

    def assign_room

    end # end #assign_room
  end # end Room class
end # Hotel module
