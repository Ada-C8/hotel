require_relative 'date_range'

module BookingSystem
  class Reservation < BookingSystem::DateRange

    class InvalidRoomError < StandardError
    end

    class InvalidPriceError < StandardError
    end

    attr_reader :reservation_dates, :room, :price, :discount_rate

    def initialize(room, check_in, check_out, price, discount_rate = 0)
      super(check_in, check_out)
      @room = room
      @price = price
      @discount_rate = discount_rate
    end

    def total_cost
      total_cost = number_of_nights * @price
      discount = total_cost * @discount_rate
      total_cost -= discount

      return total_cost
    end

  end
end
