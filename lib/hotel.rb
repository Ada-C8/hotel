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

    def all_rooms
      list = []
      @rooms.each { |room| list << room }
      list
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

    def view_reservations(date)
      date = DateRange.validate(date)
      reservations = []
      @reservations.each do |reservation|
        reservations << reservation if reservation.dates.include?(date)
      end
      reservations
    end

    def find_available_rooms(checkin, checkout, block_id = false)
      booked_rooms, available_rooms = [], []

      if block_id
        current_block = block(block_id)
        raise(InvalidDatesError, "Dates (#{checkin}, #{checkout}) do not fall within provided block #{current_block.id}") unless DateRange.overlap?(checkin, checkout, current_block.start_date, current_block.end_date)
        @rooms.each do |room|
          booked_rooms << room unless current_block.rooms.include? room
        end
      else # not in block
        @blocks.each do |block|
          booked_rooms += block.rooms if block.includes_dates?(checkin, checkout)
        end
      end

      @reservations.each do |reservation|
        if !(booked_rooms.include? reservation.room) && reservation.includes_dates?(checkin, checkout)
          booked_rooms << reservation.room
        end
      end
      @rooms.each do |room|
        available_rooms << room unless booked_rooms.include? room
      end
      available_rooms
    end

    def make_block(start_date, end_date, num_rooms, discount)
      rooms = find_available_rooms(start_date, end_date)[0...num_rooms]
      raise(NoRoomError, "Not enough available rooms for amount #{num_rooms}") if rooms.length < num_rooms
      block = Block.new(start_date, end_date, rooms, discount)
      @blocks << block
      block
    end

    def room(num)
      @rooms.each { |room| return room if room.number == num }
      nil
    end

    def block(id)
      @blocks.each { |block| return block if block.id == id }
      nil
    end
  end
end
