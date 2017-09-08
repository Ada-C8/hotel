require 'date'

module Hotel
  STANDARD_RATE = 200
  NUMBER_OF_ROOMS = 20

  class Hotel

    attr_reader :rooms, :reservations

    # get a list of all rooms
    def initialize
      @rooms = new_rooms
      @reservations = []
    end

    def new_reservation(checkin_date, checkout_date, room_number)
      reservation = Reservation.new(checkin_date, checkout_date, room_number)

      reservations << reservation
    end
    # get list of all reservations on a given date
    def reservations_on(date)
      check_date = Date.parse(date)

      reservations.select { |reserv| check_date >= reserv.checkin && check_date < reserv.checkout }
    end

    private
    def new_rooms
      rooms = []
      i = 0
      NUMBER_OF_ROOMS.times do
        rooms << Room.new(i + 1)
        i += 1
      end

      rooms
    end
  end
end
