#room
require 'awesome_print'

module HotelManagment
  class Room
    attr_reader :room_number

    RATE = 200

    def initialize(room_number)
      @room_number = room_number
    end

  end #class end
end #module end
