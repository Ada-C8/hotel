require 'date'

module Hotel
  class Booking
    attr_reader :id, :dates, :total_cost, :rooms, :cost, :check_reservations, :check_availability
    #Has_a relationship with booking
    #price/night
    # each reservation needs an id, room number, and a total cost

    def initialize(checkin, checkout, rooms, id)
      @dates = DateRange.new(checkin, checkout)
      @id = id
      @total_cost = 0
      @rooms = rooms
      # @cost = Room.new.cost
      # @rooms.each { |room| @total_cost += room.cost}
    end

    def define_total_cost
      @total_cost = (@dates.total_nights * Hotel::Room.new(1).cost)
      return @total_cost

      #for blocks - do discount logic here
    end

  end
end



# def assign_room_number
#   1..20.times do
#
#   end
# end
