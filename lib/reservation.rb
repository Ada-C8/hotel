require 'pry'
require_relative 'date_range'

module Hotel
  class Reservation

    attr_reader :id, :room, :check_in, :check_out, :date_range

    def initialize(id, room, day_in, day_out)
      @id = id
      @room = room
      @check_in = DateRange.check_in(day_in)#day_in
      @check_out = DateRange.check_out(day_out)#day_out
      @date_range = DateRange.create_range
    end

    def view_reservation
      list = ""
      list += "ID: #{@id}, Room: #{@room}, Check in: #{@check_in}, Check Out: #{@check_out}, Total Nights: #{@date_range.length - 1}"
      return list
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
