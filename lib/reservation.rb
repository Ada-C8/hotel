require 'date'
require_relative 'date_range'

module Hotel
  class Reservation
    ROOMS = %w(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)

    attr_reader :name, :dates, :room_number

    def initialize(name, check_in, check_out, room_number)
      @name = name
      @dates = Hotel::DateRange.new(check_in, check_out)
      @room_number = ROOMS[room_number.to_i - 1]
    end # end initialize
  end # end of Reservation
end # end of Hotel module
