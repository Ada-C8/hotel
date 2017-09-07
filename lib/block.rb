
module Hotel_System
  class Block < Hotel_System::Reservation
    attr_accessor :check_in, :check_out, :rooms, :rate_adjustor

    def initialize(check_in, check_out, rooms, rate_adjustor)
      @check_in = check_in
      @check_out = check_out
      @rooms = rooms
      @rate_adjustor = rate_adjustor
    end
  end
end
