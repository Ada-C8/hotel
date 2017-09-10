require 'pry'
require_relative 'date_range'
#require_relative 'reservation_list'

module Hotel
  class Reservation

    attr_reader :id, :number_of_rooms, :room, :check_in, :check_out, :date_range, :nights_reserved, :total_cost, :length_of_stay, :block_code
#@reservations.add(id, day_in, day_out, discount: 0, number_of_rooms: 1, room: first_open)
    def initialize(id, day_in, day_out, discount: 0, number_of_rooms: 1, room: first_open, block_code: nil)
      @id = id
      @check_in = DateRange.check_in(day_in)#day_in
      @check_out = DateRange.check_out(day_out)#day_out
      @date_range = DateRange.create_range(@check_in, @check_out)
      @nights_reserved = @date_range[0..-2]
      @length_of_stay = @date_range.length - 1
      @total_cost = ((200 - discount) * @length_of_stay).to_i
      @room = room
      @block_code = block_code
    end

    # def view_reservation
    #   return "ID: #{@id}, Room: #{@room}, Check in: #{@check_in}, Check Out: #{@check_out}, Total Nights: #{@length_of_stay}, Total Cost: #{@total_cost}"
    # end
  end #class

end #module

#binding.pry
#maybe checkin and checkout are entered from daterange
#total cost of res.$
#dates of reservation
#room number
#get_total()
#id/name
