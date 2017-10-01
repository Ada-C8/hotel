require_relative 'reservation'
require_relative 'helpers'

module Hotel_System
  class Room
    include Helpers

    attr_reader :room_number, :reservations, :rate_adjustor
    def initialize(room_number, rate_adjustor = 1)
      raise ArgumentError.new("Rate_adjustor must be numberic.") unless (rate_adjustor * 1.0).is_a? Float
      @room_number = room_number
      @reservations = []
      @rate_adjustor = rate_adjustor
    end

    def available?(check_in, check_out)
      overlap = []
      (check_in...check_out).each do |date|
        overlap += find_res_by_date(date)
      end
      overlap == [] ? true : false
    end

    def reserve(check_in, check_out)
      raise ArgumentError.new("Room not available for given date range") unless self.available?(check_in, check_out)

      reservation = Hotel_System::Reservation.new(check_in, check_out)
      reservation.room = self.room_number
      if self.rate_adjustor != nil
        reservation.rate_adjustor = self.rate_adjustor
      end
      @reservations.push(reservation)
      return reservation
    end
  end
end
