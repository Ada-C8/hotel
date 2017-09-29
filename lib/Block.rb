require 'Date'

module Hotel
  class Block

    attr_reader :start_date, :end_date, :discount, :rooms, :block_id

    @@blocks = []

    def initialize(start_date, end_date, number_of_rooms, discount = 0.1)
      check_input(start_date, end_date, number_of_rooms, discount)
      @block_id = Block.all.length + 1
      @start_date = start_date
      @end_date = end_date
      @discount = discount
      @rooms = sample_available_rooms(start_date, end_date, number_of_rooms)
      collect_instance
    end

    def self.rooms_left(block_id)
      block = Block.find(block_id)
      return Reservation.sample_available_rooms(block.start_date, block.end_date, block_id, block.rooms.length)
    end

    private

    extend Overlapping

    def check_input(start_date, end_date, number_of_rooms, discount)
      raise InvalidDateError if start_date.class != Date || end_date.class != Date
      raise InvalidDateError if end_date <= start_date
      raise InvalidDateError if start_date < Date.today
      raise InvalidDiscountError if discount > 1 || discount.to_s.match(/^(0(\.\d+)?|1(\.0+)?)$/) == false
      raise ArgumentError if number_of_rooms.class != Integer
      raise ArgumentError if number_of_rooms < 1 || number_of_rooms > 5
    end

    def collect_instance
      @@blocks.push(self)
    end

    def self.all
      return @@blocks
    end

    def self.find(block_id)
      return Block.all.find { |a_block| a_block.block_id == block_id }
    end

    def sample_available_rooms(start_date, end_date, number_of_rooms)
      room_numbers = Room.room_numbers
      blocked_room_numbers = room_numbers - Block.available(start_date, end_date)
      reserved_room_numbers = room_numbers - Reservation.available(start_date, end_date)
      available_room_numbers = room_numbers - blocked_room_numbers - reserved_room_numbers
      raise NoRoomsAvailableError if available_room_numbers.length < number_of_rooms
      return available_room_numbers.sample(number_of_rooms)
    end

    def self.available(start_date, end_date)
      all_rooms = Room.room_numbers
      overlapping_rooms = []
      Block.all.each do |block|
        overlapping_rooms += block.rooms if self.overlapping?(start_date, end_date, block.start_date, block.end_date) == true
      end
      return all_rooms - overlapping_rooms
    end

  end # Block class
end # Hotel module
