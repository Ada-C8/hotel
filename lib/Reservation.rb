require_relative './daterange'

module Hotel
  class Reservation

    def initialize(Hotel::DateRange.new(check_in, check_out))
      @reservation_id = 0
      @total_cost = 0
      @room_num = 0
    end


  end
end
