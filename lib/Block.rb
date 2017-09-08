require 'Date'

module Hotel
  class Block

    extend Overlapping

    attr_reader :start_date, :end_date, :discount, :rooms, :block_id

    @@blocks = []

    def initialize(start_date, end_date, number_of_rooms, discount = 0.1)
      raise ArgumentError.new("Blocks can have between 1 and 5 rooms") if (1..5).to_a.include?number_of_rooms == false
      @block_id = @@blocks.length + 1
      @start_date = start_date
      @end_date = end_date
      @discount = discount
      @rooms = sample_available_rooms(start_date, end_date, number_of_rooms)
      raise NoRoomsAvailableError if @rooms.length < number_of_rooms
      collect_instance
    end

    def collect_instance
      @@blocks.push(self)
    end

    def sample_available_rooms(start_date, end_date, number_of_rooms)
      room_numbers = Room.all.map { |room| room.room_num }
      blocked_room_numbers = room_numbers - Hotel::Block.available(start_date, end_date)
      reserved_room_numbers = room_numbers - Hotel::Reservation.available(start_date, end_date)
      available_room_numbers = room_numbers - blocked_room_numbers - reserved_room_numbers
      return available_room_numbers.sample(number_of_rooms)
    end

    def self.available(start_date, end_date)
      available_rooms = Room.all.map { |room| room.room_num }
      overlapping_blocks = @@blocks.select do |block|
        self.overlapping?(start_date, end_date, block.start_date, block.end_date) == true
      end
      overlapping_blocks.each do |block|
        available_rooms -= block.rooms
      end
      return available_rooms
    end

    def self.all
      return @@blocks
    end

    def self.rooms_left(block_id)
      block = @@blocks.select { |a_block| a_block.block_id == block_id }[0]
      return Reservation.sample_available_rooms(block.start_date, block.end_date, block_id, block.rooms.length)
    end

  end # Block class
end # Hotel module
