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
      @length_of_stay = @nights_reserved.length
      @discount = discount
      @block_name = block_name
      @total_cost = ((200 - discount) * @length_of_stay).to_i
    end


    def includes_date(date)
      if @nights_reserved.include?(Date.parse(date))
        return true
      end
    end
    #   DateRange.create_range(day_in, day_out).each do |date|
    #     found_reservations << all_reservations.find_all { |reservation| reservation.nights_reserved.include?(Date.parse(date)) }
    #   if [DateRange.create_range(@check_in, @check_out)[0..-2]].include?(Date.parse(date))
    #     return true
    #   end
    # end

    def view_reservation
      return "ID: #{@id}, Room: #{@room}, Check in: #{@check_in}, Check Out: #{@check_out}, Total Nights: #{@length_of_stay}, Total Cost: #{@total_cost}"
    end
  end
end
