require_relative 'reservation'

module Hotel_System
  class Room
    attr_reader :room_number, :reservations
    def initialize(room_number)
      @room_number = room_number
      @reservations = []
    end

    def available?(check_in, check_out)
      overlap = []
      (check_in...check_out).each do |date|
        overlap += self.reservations.select do |reservation|
          (reservation.check_in...reservation.check_out).cover?(date)
        end
      end
      overlap == [] ? true : false
    end

    def reserve(check_in, check_out)
      raise ArgumentError.new("Must pass Date object as check_in day and check_out day") unless check_in.class == Date && check_out.class == Date
      raise ArgumentError.new("Cannot check in and out on same day") if check_in == check_out
      raise ArgumentError.new("Time Warp") if (check_out <=> check_in) == -1
      raise ArgumentError.new("Room not available for given date range") unless self.available?(check_in, check_out)

      reservation = Hotel_System::Reservation.new(check_in, check_out)
      reservation.room = self.room_number
      @reservations.push(reservation)
      return reservation
    end
  end
end
