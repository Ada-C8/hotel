module BookingSystem
  class Reservation
    attr_reader :name, :check_in, :check_out, :room_num, :total_cost

    COST = 200

    def initialize(name, room_num, check_in, check_out)
      dates = DateRange.new(check_in, check_out)
      @name = name
      @check_in = dates.check_in
      @check_out = dates.check_out
      @room_num = room_num
      @total_cost = (dates.check_out - dates.check_in).to_i * COST
    end

  end # Reservation
end # BookingSystem
