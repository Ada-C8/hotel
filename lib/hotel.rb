module Hotel
  require_relative 'room'
  require_relative 'reservation'
  require_relative 'room'
  require_relative 'block'
  require_relative 'no_room_error'

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
      #TODO: add block functionality
      room_num = find_available_rooms(checkin, checkout, block).first
      if room_num.nil?
        raise(NoRoomError, "No available rooms for dates #{checkin} - #{checkout}")
      end
      reservation = Reservation.new(room_num, checkin, checkout, self, block)
      @reservations << reservation
      reservation
    end

    def room(num)
      @rooms.each do |room|
        return room if room.number == num
      end
      nil
    end

    def view_reservations(date)
      date = DateRange.validate(date)
      reservations = []
      @reservations.each do |reservation|
        reservations << reservation if reservation.dates.include?(date)
      end
      reservations
    end

    def find_available_rooms(checkin, checkout, block = false)
      # TODO: add block functionality
      booked_rooms, available_rooms = [], []
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
      block = Block.new(start_date, end_date, rooms, discount)
      @blocks << block
      block
    end
  end
end
