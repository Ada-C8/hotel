require_relative 'range'

# I can access the list of all of the rooms in the hotel
# I can reserve a room for a given date range
# I can access the list of reservations for a specific date
# I can get the total cost for a given reservation


module Property

  class Reservation < Range


    def initialize(room, check_in, check_out, total_price)
      @room = room
      @total_price = (@check_out - @check_in) * 200
      # super(check_in, check_out)
      @dates = Property::Range.new(check_in, check_out)
    end

    def reserve(room,check_in,check_out)
      reservation = Reservation.new(room, checkin, checkout, @room_price)
      @reserved_rooms << reservation
      return reservation
    end


  end
end
