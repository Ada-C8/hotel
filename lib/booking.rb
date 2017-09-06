require 'date'

module Hotel
  class Booking
    attr_reader :id, :dates, :total_cost, :rooms, :cost
    #Has_a relationship with booking
    #price/night
    # each reservation needs an id, room number, and a total cost
    def initialize(checkin, checkout, rooms, id)
      @dates = DateRange.new(checkin, checkout)
      @id = 0
      @total_cost = 0
      @rooms = Room.new.room_number
      @cost = Room.new.cost
    end

    def define_total_cost
      @total_cost = (@dates.total_nights * @cost)
      return @total_cost
    end

  end
end


# def assign_room_number
#   1..20.times do
#
#   end
# end
