require 'date'

module Hotel
  class Room
      @@rooms_available = (1..20).to_a
    end

    attr_reader :room_number, :rooms_available
    def self.rooms_available
    def initialize
      @room_number = room_number
    end # end #initialize

    def assign_room
      @room_number = @@rooms_available.shift # removes first element of array

        # go through array and remove the first room available, (shorten the number of rooms available by shortening the array) then shovel back in as guests check out
    end # end #assign_room

    def check_out_of_room
      @@rooms_available << @room_number
    end # end #check_out_of_room

    def is_available?(checkin, check_out)
    end # end #is_available?
  end # end Room class
end # Hotel module
