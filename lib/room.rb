require 'date'

module Hotel
  class Room
    rooms_available = (1..20).to_a
    attr_reader :room_number

    def initialize(room_number)
      @room_number = rooms_available[room_number-1]
    end # end #initialize

    def assign_room
      rooms_available.each do |i|
        # go through array and remove the first room available, going from lowest number to highest, return when guest checks out, continue booking the smallest numbered room
    end # end #assign_room
  end # end Room class
end # Hotel module
