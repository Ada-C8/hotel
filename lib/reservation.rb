require_relative 'date_range'

module BookingSystem
  class Reservation

    @@id_count = 1

    # price = {1 => 150, 2 => 200, 3 => 350, 4 => 120, 5 => 150, 6 => 170, 7 => 180, 8 => 150, 9 => 190, 10 => 200, 11 => 220, 12 => 135, 13 => 200, 14 => 190, 15 => 220, 16 => 200, 17 => 220, 18 => 250, 19 => 200, 20 => 250}

    attr_reader :id, :date_range, :room, :cost, :total_cost

    def initialize(date_range, room, cost)
      @id = @@id_count
      @@id_count += 1
      @date_range = date_range
      @room = room
      @cost = cost
      @total_cost = (cost * date_range.dates_within_range.length).to_f
      # @total__block_cost = @total_cost *

    end #end of initialize




  end #end of class

end #end of module
