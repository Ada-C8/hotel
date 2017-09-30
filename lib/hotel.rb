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

    def find_avail_rooms(date)
      date_reservations = self.find_res_by_date(date)
      reserved_rooms = date_reservations.map {|reservation| reservation.room }
      avail_rooms = self.rooms.reject {|room| reserved_rooms.include?(room.room_number)}
      return avail_rooms
    end

    def create_block(check_in, check_out, size, rate_adjustor)
      blockable_rooms = @rooms.select {|room| room.available?(check_in, check_out)}
      if blockable_rooms.length < size
        raise ArgumentError.new("Block of this size not available")
      end
      if size > 5
        raise ArgumentError.new("Blocks can have a maximum of 5 rooms")
      end
      rooms = blockable_rooms.sample(size)
      rooms.each {|room| room.reserve(check_in, check_out)}
      @blocks << Hotel_System::Block.new(check_in, check_out, rooms, rate_adjustor)

    end
  end
end
