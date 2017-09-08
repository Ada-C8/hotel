# require 'pry'

module BookingSystem
  class DateRange
    attr_reader :check_in, :check_out

    def initialize(check_in, check_out)
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
    end

    def overlap?(existing_reservations)
      booked_rooms = []
      existing_reservations.each do |reservation|
        if @check_in >= reservation.check_in && @check_in < reservation.check_out
          booked_rooms << reservation.room_num
        end
      end
      return booked_rooms
    end

  end # DateRange
end # BookingSystem
