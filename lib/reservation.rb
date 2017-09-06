module BookingSystem
  class Reservation
    attr_reader :stay_dates, :room_num, :total_cost

    COST = 200

    def initialize(rooms, check_in, check_out)
      # Should be an array of check in and check out date
      new_date = DateRange.new(check_in, check_out)
      #TODO: Does new date need to be an instance variable
      @stay_dates = new_date.start_end
      @room_num = rooms.sample # Currently the room 
      @total_cost = 0
    end

    def total_cost
      @total_cost = (COST * @stay_dates.length)
      return @total_cost
    end

  end # Reservation
end # BookingSystem
