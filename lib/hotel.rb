module Hotel
  require_relative 'room'
  require_relative 'reservation'
  require_relative 'room'
  require_relative 'block'
  require_relative 'no_room_error'

  class Hotel
    attr_reader :rooms, :reservations
    ROOM_COST = 200

    def initialize(num_rooms)
      @rooms = []
      num_rooms.times do |i|
        @rooms << Room.new(i+1, ROOM_COST)
      end
      @reservations = []
    end

    def all_rooms
      list = []
      @rooms.each { |room| list << room }
      list
    end

    def make_reservation(checkin, checkout)
      room_num = find_available_rooms(checkin, checkout).first
      if room_num == nil
        raise NoRoomError.new("No available rooms for dates #{checkin} - #{checkout}")
      end
      @reservations << Reservation.new(room_num, checkin, checkout, self)
    end

    def room(num)
      @rooms.each do |room|
        return room if room.number == num
      end

      nil
    end

    def view_reservations(date)
      date = DateRange::validate(date)
      reservations = []
      @reservations.each do |reservation|
        reservations << reservation if reservation.dates.include?(date)
      end
      reservations
    end

    def find_available_rooms(checkin, checkout)
      booked_rooms, available_rooms = [], []
      @reservations.each do |reservation|
        if !(booked_rooms.include?reservation.room) && reservation.includes_dates?(checkin, checkout)
          booked_rooms << reservation.room
        end
      end
      @rooms.each do |room|
        available_rooms << room unless booked_rooms.include?room
      end
      available_rooms
    end
  end
end
