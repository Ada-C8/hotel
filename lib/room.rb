require 'date'

module Hotel
  class Room
    attr_reader :room_number, :rooms_available
    def initialize
      @rooms_available = (1..20).to_a
      @room_number
    end # end #initialize

    def assign_room
      @room_number = @rooms_available.pop

        # go through array and remove the first room available, going from lowest number to highest, return when guest checks out, continue booking the smallest numbered room
    end # end #assign_room
  end # end Room class
end # Hotel module
