require 'pry'

module Hotel
  class Reservation

    attr_reader :id, :room, :check_in, :check_out

    def initialize(id, room, day_in, day_out)
      @id = id
      @room = room
      @check_in = day_in#Hotel::DateRange.check_in(day_in)
      @check_out = day_out#Hotel::DateRange.check_out(date_out)
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
