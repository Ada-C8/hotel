require 'date'

module Hotel
  class Booking
    attr_reader :id, :dates, :rooms

    def initialize(checkin, checkout, rooms, id)
      @dates = DateRange.new(checkin, checkout)
      @id = id
      @rooms = rooms
    end

    def total_cost
      total_cost = 0
      @rooms.each do |room|
        total_cost += room.cost * @dates.total_nights
      end
      return total_cost
    end

  end
end
