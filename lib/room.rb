require 'date'

module Hotel
  class Room
      ROOMS = (1..20).to_a
      @@rooms_available = ROOMS

    attr_reader :room_number, :rooms_available

    def initialize
      @room_number = room_number
    end # end #initialize

    #########################
    def self.initialize_rooms
      @@rooms_available = (1..20).to_a
    end
    #########################

    def self.rooms_available
      @@rooms_available
    end # end #rooms_available

    def assign_room
      @room_number = @@rooms_available.shift # removes first element of array
      return @room_number

        # go through array and remove the first room available, (shorten the number of rooms available by shortening the array) then shovel back in as guests check out
    end # end #assign_room

    def check_out_of_room
      @@rooms_available << @room_number
      return @@rooms_available.sort! # sort the rooms back into numerical order as they are returned to the array
    end # end #check_out_of_room

    def is_available?(checkin, check_out)
    end # end #is_available?
  end # end Room class
end # Hotel module
