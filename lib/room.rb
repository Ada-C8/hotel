#room
require 'awesome_print'

module HotelManagment
  class Room
    attr_reader :room_number, :rate

    def initialize(room_number, rate)
      @room_number = room_number
      @rate = 200
    end
  end #class end
end #module end
