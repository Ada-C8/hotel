require 'pry'
require_relative 'date_range'

module Hotel
  class Reservation

    attr_reader :id, :room, :check_in, :check_out, :date_range

    def initialize(id, room, day_in, day_out, date_range)
      @id = id
      @room = room
      @check_in = Hotel::DateRange.check_in(day_in)#day_in
      @check_out = Hotel::DateRange.check_out(day_out)#day_out
      #@date_range = Hotel::DateRange.
    end

  end #class
end #module
#binding.pry
#maybe checkin and checkout are entered from daterange
#total cost of res.$
#dates of reservation
#room number
#get_total()
#id/name
