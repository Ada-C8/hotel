require_relative 'date_range'

module BookingSystem
  class Reservation

    @@id_count = 1

    attr_reader :id, :date_range, :room, :cost, :total_cost

    def initialize(date_range, room, cost)

      @id = @@id_count
      @@id_count += 1
      @date_range = date_range
      @room = room
      @cost = cost
      @total_cost = (cost * date_range.dates_within_range.length).to_f

    end #end of initialize

  end #end of class

end #end of module
