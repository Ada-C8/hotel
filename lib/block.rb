module BookingSystem
  class Block
    attr_reader :number_of_rooms, :date_range, :rooms_in_block, :rooms_available

    ROOM_PRICE = 200
    DISCOUNTED_PRICE = ROOM_PRICE - (ROOM_PRICE * 0.15)

    def initialize(number_of_rooms, rooms_in_block, check_in, check_out)

      CheckUserInput.integer(number_of_rooms)
      CheckUserInput.between_1_5(number_of_rooms)

      @number_of_rooms = number_of_rooms
      @rooms_in_block = rooms_in_block
      @rooms_available = rooms_in_block
      @date_range = BookingSystem::DateRange.new(check_in, check_out).all_reservation_dates
    end

    def remove_reserved_room_from_availability(reserved_room)
      @rooms_available.delete(reserved_room)
      return @rooms_available
    end

    def block_total_cost
      return DISCOUNTED_PRICE * @date_range.length * @number_of_rooms
    end

  end
end
