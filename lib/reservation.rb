
module Hotel_System
  class Reservation
    attr_accessor :check_in, :check_out, :room, :rate_adjustor
    def initialize(check_in, check_out)
      raise ArgumentError.new("Check_in Date object, check_out Date object") unless check_in.class == Date && check_out.class == Date
      raise ArgumentError.new("Cannot check in and out on same day") if check_in == check_out
      raise ArgumentError.new("Time Warp") if (check_out <=> check_in) == -1

      @check_in = check_in
      @check_out = check_out
      @room = nil
      @rate_adjustor = 1
    end
    def cost
      ((@check_out - @check_in) * 200 * rate_adjustor).to_int
    end
  end
end
