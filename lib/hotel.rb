# hotel
require_relative 'room.rb'

module HotelManagment
  class Hotel
    attr_reader :rooms
    def initialize
      @rooms = []
    end

    def add_20_rooms
      num = 1
      20.times do
        room = HotelManagment::Room.new(num,"available")
        @rooms << room
        num += 1
      end
    end



  end #class end
end #module end
