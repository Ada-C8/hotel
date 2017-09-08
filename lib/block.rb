require_relative 'reservation'

class Block < Reservation

  attr_reader :price_night, :rooms

  def initialize(room, check_in, check_out)

    @rooms = room
    @dates = DateRange.new(check_in, check_out)
    @price_night = 160
    @nights = (check_out-check_in)

    @total_cost = @price_night * @dates.nights

    # super


    if room.length > 5 || room.length < 1
      raise ArgumentError.new("You can only block 1 to 5 rooms.")
    end
  end

  # returns total_cost for stay
  def total_cost
    total_cost = @price_night * @dates.nights
    return total_cost
  end


end


# check_out = Date.new(2017, 03, 14)
# check_in = Date.new(2017, 03, 11)
# test = Block.new(1, check_in, check_out)

# print test.price_night
# print test.total_cost
