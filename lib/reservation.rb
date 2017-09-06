
module Hotel_System
  class Reservation
    attr_accessor :check_in, :check_out, :room
    def initialize(check_in, check_out)
      raise ArgumentError.new("Must pass Date object as check_in day and check_out day") unless check_in.class == Date && check_out.class == Date
      raise ArgumentError.new("Cannot check in and out on same day") if check_in == check_out
      raise ArgumentError.new("Time Warp") if (check_out <=> check_in) == -1

      @check_in = check_in
      @check_out = check_out
      @room = nil
    end
    def cost
      ((@check_out - @check_in) * 200).to_int
    end
  end
end
