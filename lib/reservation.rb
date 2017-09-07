require 'pry'

module Hotel
  class Reservation

    attr_reader :id, :room, :check_in, :check_out

    def initialize #(id, room, check_in, check_out)
      @ID = id
      @room = room
      @check_in = check_in
      @check_out = check_out
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
