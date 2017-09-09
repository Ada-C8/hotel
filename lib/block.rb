module BookingSystem
  class Block
    attr_reader :number_of_rooms, :date_range, :rooms_in_block, :rooms_available

    def initialize(number_of_rooms, rooms_in_block, check_in, check_out)
      @number_of_rooms = number_of_rooms
      @rooms_in_block = rooms_in_block
      @rooms_available = rooms_in_block
      @date_range = BookingSystem::DateRange.new(check_in, check_out).all_reservation_dates
    end

    def remove_reserved_room_from_availability(reserved_room)
    @rooms_available.delete(reserved_room)
      return @rooms_available
    end
  end
end
