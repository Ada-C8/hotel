require_relative 'date_range'

module BookingSystem
  class Block < BookingSystem::DateRange
    attr_reader :block_id, :number_of_rooms, :rooms_in_block, :rooms_available

    @@block_count = 0

    def initialize(number_of_rooms, rooms_in_block, check_in, check_out)
      @@block_count += 1
      @block_id = @@block_count
      @number_of_rooms = number_of_rooms
      @rooms_in_block = rooms_in_block
      @rooms_available = rooms_in_block
      super(check_in, check_out)
    end

    def remove_reserved_room_from_availability(reserved_room)
    @rooms_available.delete(reserved_room)
      return @rooms_available
    end

    def self.block_count
      @@block_count
    end

  end
end

    # def self.block_count
    #   return @@block_count
    # end
