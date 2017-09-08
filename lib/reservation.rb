module BookingSystem
  class Reservation

    class InvalidRoomError < StandardError
    end

    attr_reader :reservation_dates, :room

    ROOM_PRICE = 200

    def initialize(room, check_in, check_out)

      CheckUserInput.integer(room)
      CheckUserInput.between_1_20(room)

      @room = room
      @reservation_dates = DateRange.new(check_in, check_out).all_reservation_dates

    end

  def total_cost
    total_cost = @reservation_dates.length * ROOM_PRICE
    return total_cost
  end

  end
end
