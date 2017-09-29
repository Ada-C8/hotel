require_relative 'reservation'
require 'Money'
Money.use_i18n = false

module Hotel
  class Block
    class NoRoomsError < StandardError ; end
    class WrongNumberOfRoomsError < StandardError ; end

    attr_reader :price_night, :rooms, :dates, :name

    def initialize(name, rooms, check_in, check_out, price_night)
      @name = name
      @rooms = rooms
      @price_night = price_night
      @dates = DateRange.new(check_in, check_out)
      @available_rooms = rooms.dup
      @reserved_rooms = []

      if rooms.length > 5 || rooms.length < 1
        raise WrongNumberOfRoomsError.new("You can only block 1 to 5 rooms.")
      end
    end

    # returns total_cost for stay
    def total_cost
      total_cost = (@price_night * @dates.nights)
      return Money.new(total_cost * 100, "USD").format
    end

    # Boolean of room availability
    def rooms_available?
        return @available_rooms.length > 0
    end

    # reserve room if available
    def reserve_room
      unless rooms_available?
        raise NoRoomsError.new("All rooms are reserved.")
      end
      room = @available_rooms.pop
      @reserved_rooms << room
      return room
    end

  end
end
