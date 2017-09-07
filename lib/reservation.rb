module BookingSystem
  class Reservation
    attr_reader :check_in, :check_out, :stay_dates, :room_num, :total_cost

    COST = 200

    def initialize(room_num, check_in, check_out)
      # Should be an array of check in and check out date
      #TODO: Does new date need to be an instance variable
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @stay_dates = DateRange.new(check_in, check_out).start_end
      @room_num = room_num # Currently a single room number
      @total_cost = 0
    end

    def calculate_cost
      @total_cost = (COST * (@stay_dates.length - 1))
      return @total_cost
    end


  end # Reservation
end # BookingSystem
