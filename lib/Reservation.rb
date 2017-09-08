require 'Date'

module Hotel
  class Reservation

    attr_reader :block_id, :start_date, :end_date, :room_num

    @@reservations = []

    def initialize(block_id = nil, start_date = Date.today, end_date = Date.today + 1, room_num = 0)
      check_input(block_id, start_date, end_date, room_num)
      @block_id = block_id
      set_reservation_dates(block_id, start_date, end_date)
      room_num = Reservation.sample_available_rooms(start_date, end_date, block_id).sample if room_num == 0
      prevent_booking_blocked(room_num, block_id)
      prevent_doublebooking(start_date, end_date, room_num)
      @room_num = room_num
      collect_instance
    end

    def self.all(date = nil)
      return @@reservations if date == nil
      return @@reservations.select { |reservation| reservation.start_date <= date && reservation.end_date >= date }
    end

    def self.available(start_date, end_date)
      all_rooms = Room.all.map { |room| room.room_num }
      overlapping_rooms = Reservation.all.map do |reservation|
        reservation.room_num if self.overlapping?(start_date, end_date, reservation.start_date, reservation.end_date) == true
      end
      return all_rooms - overlapping_rooms
    end

    def total
      rate = Room.all.find { |room| room.room_num == room_num }.rate
      discount = 0
      discount = Block.all.find { |block| block.block_id == block_id }.discount if block_id != nil
      return ((end_date- start_date) * rate * (1 - discount)).to_i
    end

    private

    extend Overlapping

    def check_input(block_id, start_date, end_date, room_num)
      raise InvalidDateError if start_date.class != Date || end_date.class != Date
      raise InvalidDateError if end_date <= start_date
      raise InvalidDateError if start_date < Date.today
      raise ArgumentError if block_id != nil && block_id.class != Integer
      raise ArgumentError if room_num.class != Integer
    end

    def prevent_doublebooking(start_date, end_date, room_num)
      raise AlreadyBookedError if Reservation.available(start_date, end_date).include?(room_num) == false
    end

    def prevent_booking_blocked(room_num, block_id)
      if block_id == nil
        room_numbers = Room.all.map { |room| room.room_num }
        blocked_room_numbers = room_numbers - Block.available(start_date, end_date)
        raise BlockedRoomError if blocked_room_numbers.include?(room_num)
      end
    end

    def set_reservation_dates(block_id, start_date, end_date)
      if block_id == nil
        @start_date = start_date
        @end_date = end_date
      else
        set_block_dates(block_id)
      end
    end

    def set_block_dates(block_id)
      block = Block.all.find { |a_block| a_block.block_id == block_id }
      @start_date = block.start_date
      @end_date = block.end_date
    end

    def self.sample_available_rooms(start_date, end_date, block_id, number_of_rooms = 1)
      if block_id == nil
        room_numbers = Room.all.map { |room| room.room_num }
        blocked_room_numbers = room_numbers - Block.available(start_date, end_date)
      else
        room_numbers = Block.all.find { |block| block.block_id == block_id }.rooms
        blocked_room_numbers = []
      end
      reserved_room_numbers = room_numbers - Reservation.available(start_date, end_date)
      available_room_numbers = room_numbers - blocked_room_numbers - reserved_room_numbers
      raise NoRoomsAvailableError.new if available_room_numbers.length < 1
      return available_room_numbers.sample(number_of_rooms)
    end

    def collect_instance
      @@reservations.push(self)
    end

  end # Reservation class
end # Hotel module
