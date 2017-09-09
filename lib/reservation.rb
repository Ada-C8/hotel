module BookingSystem
  class Reservation

    class InvalidRoomError < StandardError
    end

    class InvalidPriceError < StandardError
    end

    attr_reader :reservation_dates, :room, :price

    def initialize(room, check_in, check_out, price)
      @room = room
      @reservation_dates = DateRange.new(check_in, check_out).all_reservation_dates
      @price = price
    end

  def total_cost
    total_cost = @reservation_dates.length * @price
    return total_cost
  end

  end
end
