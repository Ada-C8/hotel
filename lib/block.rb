module BookingSystem
  class Block
    attr_reader :number_of_rooms, :date_range

    ROOM_PRICE = 200
    DISCOUNTED_PRICE = ROOM_PRICE - (ROOM_PRICE * 0.15)

    def initialize(number_of_rooms, check_in, check_out)

      unless number_of_rooms.class == Integer
        raise ArgumentError.new("Number of rooms must be an integer (e.g., 1, 2, 3). Given input: #{number_of_rooms}")
      end

      @number_of_rooms = number_of_rooms
      @date_range = BookingSystem::DateRange.new(check_in, check_out).all_reservation_dates
    end

    # #The collection of rooms should only include rooms that are available for the given date range
    # def collection_of_rooms
    #
    #   return []
    # end

    def block_total_cost

      return DISCOUNTED_PRICE * @date_range.length * @number_of_rooms
    end

  end
end
