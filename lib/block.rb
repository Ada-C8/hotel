require_relative 'reservation'
require 'Money'
Money.use_i18n = false

class Block

  attr_reader :price_night, :rooms, :dates, :name

  def initialize(name, rooms, check_in, check_out)
    @name = name
    @rooms = rooms
    @price_night = 160
    @dates = DateRange.new(check_in, check_out)

    if rooms.length > 5 || rooms.length < 1
      raise ArgumentError.new("You can only block 1 to 5 rooms.")
    end
  end

  # returns total_cost for stay
  def total_cost
    total_cost = (@price_night * @dates.nights)
    return Money.new(total_cost * 100, "USD").format
  end

end
