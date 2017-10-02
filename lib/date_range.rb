require 'date'

module BookingSystem
  class DateRange
    attr_reader :check_in, :check_out

    def initialize(check_in, check_out)
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
    end

    # A reservation is allowed start on the same day that another reservation for the same room ends
    def overlap(existing_reservations)
      booked_rooms = []
      existing_reservations.each do |reservation|
        if @check_out >= reservation.check_in && @check_out < reservation.check_out || @check_in >= reservation.check_in && @check_in < reservation.check_out || @check_in > reservation.check_in && @check_out < reservation.check_out
          if reservation.class == BookingSystem::Block
            reservation.avail_block_rooms.map { |block_room_num| booked_rooms << block_room_num }
          else
            booked_rooms << reservation.room_num
          end
        end
      end
      return booked_rooms
    end

    def valid_dates? # Your code should raise an error when an invalid date range is provided
      # pattern = /\d{4}\W\d+\W\d+/
      raise ArgumentError.new("Invalid dates") if @check_in > @check_out
    end

  end # DateRange
end # BookingSystem
