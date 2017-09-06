module BookingSystem
  class Reservation
    attr_reader :stay_dates, :room_num, :total_cost

    COST = 200.00

    def initialize(rooms, check_in, check_out)
      # Should be an array of check in and check out date
      # May have to change to this a date range?
      new_date = DateRange.new(check_in, check_out)
      @stay_dates = new_date.start_end
      @room_num = rooms.sample # Currently the room
      @total_cost = 0
    end
    # How do I get the number of nights?
    # def total_cost(nights)
    #   # COST * nights = total_cost
    #   # return total
    # end

  end # Reservation
end # BookingSystem
