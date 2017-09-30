#block_reservation

#i misunderstood what this meant at first. i now realize i need to set aside a block of rooms to reserve.

class Block
  MAX_ROOMS = 5
  attr_reader :rooms, :discount, :nights, :reservations, :id, :nights_reserved
  def initialize(check_in, check_out, rooms, discount=1)
    if rooms.length > MAX_ROOMS
      raise ArgumentError.new("Cannot set aside more than 5 rooms in a block")
    end
    @id = rand(100000..999999)
    @rooms = rooms
    @discount = discount
    @nights = Nights.new(check_in, check_out)
    @nights_reserved = @nights.nights_reserved
    @reservations = []
  end

  def make_reservation(room_numbers)
    rooms_to_reserve = []

    room_numbers.each do |room|
      @rooms.each do |room_in_block|
        if room_in_block.number == room
          rooms_to_reserve.push(room_in_block)
        end
      end
    end

    if rooms_to_reserve.empty?
      raise ArgumentError.new("That room number is not available for reservation within this block")
    else
      reservation = Reservation.new(@nights.check_in.to_s, @nights.check_out.to_s, rooms_to_reserve, @discount)
      @reservations.push(reservation)
      return reservation
    end
  end
end
