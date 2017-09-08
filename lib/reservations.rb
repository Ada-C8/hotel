require 'date'
require 'rooms'

module Hotels
  class Reservations
    attr_reader :room, :date_range
    def initialize(room, date_range)
      @room = room
      @date_range = date_range
    end

    def calculate_bill
      cost = @date_range.length * @room.price
      return cost 
    end



  end
end
