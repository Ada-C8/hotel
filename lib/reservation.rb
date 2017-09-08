module BookingSystem
  class Reservation

    class InvalidRoomError < StandardError
    end

    attr_reader :reservation_dates, :room

    ROOM_PRICE = 200

    def initialize(room, check_in, check_out)

      CheckUserInput.integer(room)
      CheckUserInput.between_1_20(room)  
      # if room.class != Integer
      #   raise InvalidRoomError.new("Room number must be entered as a digit (e.g., 1, 2, 3...). Input given: #{room}")
      # end
      #
      # if room > 20 || room < 1
      #   raise InvalidRoomError.new("Room number must be between 1 and 20. Input given: #{room}")
      # end

      @room = room
      @reservation_dates = DateRange.new(check_in, check_out).all_reservation_dates

    end

  def total_cost
    total_cost = @reservation_dates.length * ROOM_PRICE
    return total_cost
  end

  end
end
