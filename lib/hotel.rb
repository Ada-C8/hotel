# require_relative
# The hotel has 20 rooms, and they are numbered 1 through 20
# Every room is identical, and a room always costs $200/night
# The last day of a reservation is the checkout day,
# so the guest should not be charged for that night
# For this wave, any room can be reserved at any time,
# and you don't need to check whether reservations
# conflict with each other (this will come in wave 2!)

module Property

  class Hotel

    attr_reader :rooms, :room_price

    def initialize
      @rooms = (1..20).to_a
      @room_price = 200
      @reserved_rooms = [] #reservations
      @reserved_blocks = []
    end
  end
end

def reserve(room,check_in,check_out)
  reservation = Property::Reservation.new(room, checkin, checkout, @room_price)
  @reserved_rooms << reservation
  return reservation
end
