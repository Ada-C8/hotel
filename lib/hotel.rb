require_relative 'room'
require_relative 'block'

module Hotel_System
  class Hotel
    include Helpers
    attr_reader :number_of_rooms, :rooms, :blocks
    def initialize(number_of_rooms)
      @number_of_rooms = number_of_rooms
      @rooms = []
      number_of_rooms.times do |i|
        @rooms << Hotel_System::Room.new(i + 1)
      end
      @blocks = []
    end

    def reservations
      reservations = []
      @rooms.each do |room|
        if room.reservations != []
          reservations += room.reservations
        end
      end
      return reservations
    end

    def find_avail_rooms(check_in, check_out)
      @rooms.select {|room| room.available?(check_in, check_out)}
    end

    def create_block(check_in, check_out, size, rate_adjustor)
      blockable_rooms = find_avail_rooms(check_in, check_out)
      raise ArgumentError.new("Blocks can have a maximum of 5 rooms") if size > 5
      raise ArgumentError.new("Block of this size not available") if blockable_rooms.length < size
      rooms = blockable_rooms.sample(size)
      rooms.each {|room| room.reserve(check_in, check_out)}
      @blocks << Hotel_System::Block.new(check_in, check_out, rooms, rate_adjustor)
    end
  end
end
