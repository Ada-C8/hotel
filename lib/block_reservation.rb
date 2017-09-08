module BookingSystem
  class BlockReservation < BookingSystem::Reservation

    attr_reader :room, :reservation_dates

    DISCOUNTED_PRICE = ROOM_PRICE - (ROOM_PRICE * 0.15)

    def initialize(room, check_in, check_out)
      super(room, check_in, check_out)
    end

    def total_cost
      return DISCOUNTED_PRICE * @reservation_dates.length
    end

  end
end
