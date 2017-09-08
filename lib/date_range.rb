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
            if reservation.class == BookingSystem::Block
              reservation.reserved_rooms.each do |block_room_num|
                booked_rooms << block_room_num
              end
            else
              booked_rooms << reservation.room_num
            end
            # raise "This room is currently booked for your requested dates"
            # If room_num is an array do something else else do normal
            # Iterate over each room number and push it all into the booked rooms
          end
        end
      return booked_rooms
    end

  end # DateRange
end # BookingSystem
