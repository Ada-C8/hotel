require 'pry'
require_relative 'date_range'

module Hotel
  class Reservation

    attr_reader :id, :check_in, :check_out, :room, :nights_reserved, :total_cost, :length_of_stay, :block_name

    def initialize(id, day_in, day_out, discount, block_name, room: 0)
      @id = id
      @check_in = DateRange.check_in(day_in)
      @check_out = DateRange.check_out(day_out)
      @room = room
      @nights_reserved = DateRange.create_range(@check_in, @check_out)[0..-2]
      @discount = discount
      @block_name = block_name
      @total_cost = ((200 - discount) * @nights_reserved.length).to_i
    end


    def includes_date(date)
      if @nights_reserved.include?(Date.parse(date))
        return true
      end
    end

    def view_reservation
      return "ID: #{@id}, Room: #{@room}, Check in: #{@check_in}, Check Out: #{@check_out}, Total Nights: #{@nights_reserved.length}, Total Cost: #{@total_cost}"
    end
  end
end
