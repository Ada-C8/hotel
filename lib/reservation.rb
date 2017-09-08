require 'pry'
require_relative 'date_range'

module Hotel
  class Reservation

    attr_reader :id, :room, :check_in, :check_out, :date_range, :total_cost, :length_of_stay

    def initialize(id, room, day_in, day_out)
      @id = id
      @room = room
      @check_in = DateRange.check_in(day_in)#day_in
      @check_out = DateRange.check_out(day_out)#day_out
      @date_range = DateRange.create_range(@check_in, @check_out)
      @length_of_stay = @date_range.length - 1
      @total_cost = (200 * @length_of_stay).to_i
    end

    def view_reservation
      return "ID: #{@id}, Room: #{@room}, Check in: #{@check_in}, Check Out: #{@check_out}, Total Nights: #{@length_of_stay}, Total Cost: #{@total_cost}"
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
