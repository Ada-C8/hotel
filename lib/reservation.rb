require 'pry'
require_relative 'date_range'
#require_relative 'reservation_list'

module Hotel
  class Reservation

    attr_reader :id, :check_in, :check_out, :number_of_rooms, :room, :nights_reserved, :total_cost, :length_of_stay, :block_code

    def initialize(id, day_in, day_out, discount: 0, number_of_rooms: 1, room: first_open, block_code: nil)
      @id = id
      @room = room
      @check_in = DateRange.check_in(day_in)#day_in
      @check_out = DateRange.check_out(day_out)#day_out
      @nights_reserved = DateRange.create_range(@check_in, @check_out)[0..-2]
      @length_of_stay = @nights_reserved.length
      @total_cost = ((200 - discount) * @length_of_stay).to_i
      @block_code = block_code
    end

    def view_reservation
      return "ID: #{@id}, Room: #{@room}, Check in: #{@check_in}, Check Out: #{@check_out}, Total Nights: #{@length_of_stay}, Total Cost: #{@total_cost}"
    end
  end #class

end #module

#binding.pry
#maybe checkin and checkout are entered from daterange
#@reservations.add(id, day_in, day_out, discount: 0, number_of_rooms: 1, room: first_open)
