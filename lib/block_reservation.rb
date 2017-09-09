module BookingSystem
  class BlockReservation < BookingSystem::Reservation

    attr_reader :room, :reservation_dates, :price

    DISCOUNT_RATE = 0.15

    def initialize(room, check_in, check_out, price)
      super
    end

    def discount_price
      return (@price - @price * DISCOUNT_RATE)
    end

    def total_cost
      return discount_price * @reservation_dates.length
    end

  end
end
