
module Hotel_System
  class Room
    attr_reader :room_number
    attr_accessor :reservations
    def initialize(room_number)
      @room_number = room_number
      @reservations = []
    end

    def reserve(check_in, check_out)
      reservation = Hotel_System::Reservation.new(check_in, check_out)
      reservation.room = self.room_number
      @reservations.push(reservation)
      return reservation
    end
  end
end
