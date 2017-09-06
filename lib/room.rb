require 'pry'
require 'date'

module Hotel
  class Room
    attr_reader :room_number, :cost

    def initialize(room_number)
      @room_number = room_number
      @cost = 200
    end
  end
end
