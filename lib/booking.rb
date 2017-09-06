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
    #initialize will have the following parameters
    #@rooms = @rooms.each {|room| @total_cost += room.cost}
    # def total_cost
    # end
  end
end
