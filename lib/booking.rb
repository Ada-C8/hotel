require 'pry'
require 'date'

module Hotel
  class Booking
    attr_reader :id, :rooms, :date_range, :nights, :total_cost

    def initialize(id, rooms, date_range)
      @id = id
      @rooms = rooms
      @date_range = date_range
      @nights = date_range.nights
      @total_cost = ''
    end
    # figure out total cost method and them put it in initialize
    #@rooms = @rooms.each {|room| @total_cost += room.cost}
  end
end
