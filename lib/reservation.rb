require_relative 'date_range'

module Hotel
  class Reservation
    attr_reader :dates, :room

    def initialize(name, room, check_in, check_out)
      @name = name
      @room = room
      @dates = DateRange.new(check_in, check_out)
      @price_night = 200
    end

    # returns total_cost for stay
    def total_cost
      total_cost = (@price_night * @dates.nights)
      return Money.new(total_cost * 100, "USD").format
    end

  end
end
