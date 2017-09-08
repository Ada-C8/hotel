require 'date'

module Hotel
  class Booking
    attr_reader :id, :date_range, :rooms, :total_cost, :block

    # change to include: (id, rooms[], date_range)

    def initialize(id, rooms, date_range, block: false)
      @id = id
      @date_range = date_range
      @rooms = rooms
      @total_cost = 0
      #this is a mess fix it
      @rooms.each { |room| @total_cost += room.cost}
      @block = block
    end

    # def add_room(room)
    #   @rooms << room.number
    #   @total_cost += room.cost
    # end

  end
end
