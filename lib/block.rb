require_relative 'reservation'

class Block

  attr_reader :price_night, :rooms, :dates, :name

  def initialize(name, rooms, check_in, check_out)
    @name = name
    @rooms = rooms
    @price_night = 160
    @dates = DateRange.new(check_in, check_out)

    # super
    if rooms.length > 5 || rooms.length < 1
      raise ArgumentError.new("You can only block 1 to 5 rooms.")
    end
  end

  # def rooms
  #
  #
  # end

  # returns total_cost for stay
  # def total_cost
  #   total_cost = @price_night * @dates.nights
  #   return total_cost
  # end
  #
  # def nights
  #   nights = (check_out-check_in)
  #   return nights
  # end

end


# check_out = Date.new(2017, 03, 14)
# check_in = Date.new(2017, 03, 11)
# test = Block.new(1, check_in, check_out)

# print test.price_night
# print test.total_cost
