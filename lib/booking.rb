# require 'pry'
# require 'date'

module Hotel
  class Booking
    attr_reader :id, :rooms, :date_range, :nights, :total_cost

    def initialize(id, rooms, date_range)
      @id = id
      @rooms = rooms
      @date_range = date_range
      @nights = date_range.nights
      @total_cost = (@nights * rooms.inject(0){|sum,room| sum + room.cost})
    end
  end
end
