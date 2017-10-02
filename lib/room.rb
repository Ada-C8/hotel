require 'pry'
require 'date'

module Hotel
  class Room
    attr_reader :room_number, :cost, :booked
    attr_accessor :booked 

    def initialize(room_number, booked: nil)
      @room_number = room_number
      @cost = 200
      @booked = booked
    end
  end
end
