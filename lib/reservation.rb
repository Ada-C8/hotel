
module Hotel_System
  class Reservation
    attr_accessor :check_in, :check_out, :room
    def initialize(check_in, check_out)
      @check_in = check_in
      @check_out = check_out
      @room = nil
    end
    def cost
      ((@check_out - @check_in) * 200).to_int
    end
  end
end
