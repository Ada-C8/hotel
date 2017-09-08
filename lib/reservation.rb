module BookingSystem
  class Reservation
    attr_reader :check_in, :check_out, :room_num, :total_cost

    COST = 200

    def initialize(room_num, check_in, check_out)
      dates = DateRange.new(check_in, check_out)
      @check_in = dates.check_in
      @check_out = dates.check_out
      @room_num = room_num
      @total_cost = 0
    end

    def calculate_cost
      @total_cost = (@check_out - @check_in).to_i * COST
    end

  end # Reservation
end # BookingSystem
