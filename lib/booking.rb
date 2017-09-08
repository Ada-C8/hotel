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
      # @total_cost = 0
      @rooms = rooms
      # @cost = Room.new.cost
      # @rooms.each { |room| @total_cost += room.cost}
    end

    def total_cost
      total_cost = 0
      @rooms.each do |room|
        total_cost += room.cost * @dates.total_nights
      end
      return total_cost
      #for blocks - do discount logic here
    end
  end
end
# def block_total_cost
#   block_total_cost = 0
#   @collection_of_rooms_blocked.each do |room|
#     block_total_cost += room.cost * @dates.total_nights * 0.80
#   end
#   return block_total_cost
# end



# def assign_room_number
#   1..20.times do
#
#   end
# end
