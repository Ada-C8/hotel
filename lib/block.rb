module BookingSystem
  class Block
    attr_reader :number_of_rooms, :date_range, :all_room_numbers

    ROOM_PRICE = 200
    DISCOUNTED_PRICE = ROOM_PRICE - (ROOM_PRICE * 0.15)

    def initialize(number_of_rooms, all_room_numbers, check_in, check_out)

      unless number_of_rooms > 0
        raise ArgumentError.new("Number of rooms must be a positive integer (e.g., 1, 2, 3). Given input: #{number_of_rooms}")
      end

      @number_of_rooms = number_of_rooms
      @all_room_numbers = all_room_numbers
      @date_range = BookingSystem::DateRange.new(check_in, check_out).all_reservation_dates
    end

    def block_total_cost
      return DISCOUNTED_PRICE * @date_range.length * @number_of_rooms
    end

  end
end
