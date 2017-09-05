require 'Date'
require_relative 'Room'

module Hotel
  class Reservation

    def initialize(start_date = Date.today, end_date = Date.today + 1, room_num = 0)
      @start_date = start_date
      @end_date = end_date
      room_num = Room.all.sample[:room_num] if room_num == 0
      @room_num = room_num
    end


  end # Reservation class
end # Hotel module
