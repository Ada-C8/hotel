module BookingSystem
  class Hotel
    attr_reader :rooms, :all_reservations
    def initialize
      @rooms = (1..20).to_a
      @all_reservations = []
    end

    def make_reservation(room, check_in, check_out)
      reservation = BookingSystem::Reservation.new(room, check_in, check_out)
      @all_reservations << reservation
      return reservation
    end

    def available_rooms
      return []
    end

  end
end
