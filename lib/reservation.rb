
module Hotel
  class Reservation
    attr_reader :id, :total_cost, :date1, :date2, :daterange, :room_number, :cost

    def initialize(id, date1, *date2, room_number, cost) # partyname = nil)
      @id = id
      @daterange = DateRange.new(date1, *date2)
      @room_number = room_number
      @cost = cost
      # @name = *name
    end

    def get_cost
      @total_cost = (cost * @daterange.number_days)
    end

  end
#end of class
end

#end of module
