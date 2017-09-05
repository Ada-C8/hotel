#Room.rb
require 'awesome_print'

module Hotel_Chain
  class Room

  attr_reader :room_id, :rate

    def initialize(room_id, rate = 200) #Test gives warning that STD_RATE Is not initialized if i sub it for 200
      @room_id = room_id
      @rate = rate
    end

  end
end
