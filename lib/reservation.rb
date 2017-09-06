module BookingSystem
  class Reservation
    attr_reader :reservation_dates, :room

    def initialize(room, check_in, check_out)
      @room = room
      @reservation_dates = DateRange.new(check_in, check_out).all_reservation_dates

    end

  end
end
