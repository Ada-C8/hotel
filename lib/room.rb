#Room.rb
require 'awesome_print'

module Hotel_Chain
  class Room

  attr_reader :room_id
  attr_accessor :rate

    def initialize(room_id, rate = 200)
      @room_id = room_id
      @rate = rate
    end

  end
end
