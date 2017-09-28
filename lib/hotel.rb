require 'pry'

module Hotel
  require_relative 'room'
  require_relative 'reservation'
  require_relative 'room'
  require_relative 'block'
  require_relative 'exceptions'

  class Hotel
    attr_reader :rooms, :reservations, :blocks
    ROOM_COST = 200

    def initialize(num_rooms)
      @rooms = []

      num_rooms.times do |i|
        @rooms << Room.new(i + 1, ROOM_COST)
      end
      @reservations = []
      @blocks = []
    end

    def make_reservation(checkin, checkout, block = false)
      room_num = find_available_rooms(checkin, checkout, block).first
      if room_num.nil?
        raise(NoRoomError, "No available rooms for dates #{checkin} - #{checkout}")
      end
      reservation = Reservation.new(room_num, checkin, checkout, self, block)
      @reservations << reservation
      reservation
    end

    def make_block(start_date, end_date, num_rooms, discount = 0)
      raise(ArgumentError,"Number of rooms must be Integer: is #{num_rooms.class}") unless num_rooms.class == Integer

      rooms = find_available_rooms(start_date, end_date)[0...num_rooms]

      raise(NoRoomError, "Not enough available rooms for amount #{num_rooms}") if rooms.length < num_rooms

      block = Block.new(start_date, end_date, rooms, discount)
      @blocks << block
      block
    end

    def view_reservations(date)
      date = DateRange.validate(date)
      reservations = []
      @reservations.each do |reservation|
        reservations << reservation if reservation.dates.include?(date)
      end
      reservations
    end

    def find_available_rooms(checkin, checkout, block_id = false)
      DateRange.validate_order(checkin, checkout)
      if block_id
        unless block_exists?(block_id)
          raise(NoBlockError, "No such block: #{block_id}")
        end
        unless block(block_id).includes_dates?(checkin, checkout)
          raise(DatesError, "Dates (#{checkin}, #{checkout}) do not fall within provided block #{block(block_id).id}")
        end
        rooms = block(block_id).rooms
      else
        rooms = find_rooms_not_in_blocks(checkin, checkout)
      end

      @reservations.each do |reservation|
        rooms.delete(reservation.room) if (rooms.include? reservation.room) && reservation.includes_dates?(checkin, checkout)
      end
      rooms
    end

    def block_availability?(checkin, checkout, block_id)
      find_available_rooms(checkin, checkout, block_id) != []
    end

    def room(num)
      @rooms.each { |room| return room if room.number == num }
      nil
    end

    def block(id)
      @blocks.each { |block| return block if block.id == id }
      nil
    end

    # private
    def find_rooms_not_in_blocks(start_date, end_date)
      rooms = @rooms.dup
      @blocks.each do |block|
        if block.includes_dates?(start_date, end_date)
          rooms.delete_if { |room| block.rooms.include? room }
        end
      end
      rooms
    end

    def block_exists?(block_id)
      block(block_id) != nil
    end
  end
end
