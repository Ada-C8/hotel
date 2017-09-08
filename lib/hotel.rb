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
      if rooms_available(checkin_date, checkout_date).any? { |room| room.number == room_number }
        reservation = Reservation.new(checkin_date, checkout_date, room_number)

        reservations << reservation
      else
        raise ArgumentError.new("Room is not available for those dates.")
      end
    end
    # get list of all reservations on a given date
    def reservations_on(date)
      check_date = Date.strptime(date, '%m-%d-%Y')

      reservations.select { |reserv| check_date >= reserv.checkin && check_date < reserv.checkout }
    end

    def rooms_available(checkin_date, checkout_date)
      checkin = Date.strptime(checkin_date, '%m-%d-%Y')
      checkout = Date.strptime(checkout_date, '%m-%d-%Y')
      booked_rooms = []
      checkin.upto(checkout) do |date|
        booked_rooms << reservations_on(date.strftime('%m-%d-%Y')).collect { |reserv| reserv.room }
      end

      booked_rooms.flatten!.uniq!

      rooms.reject { |room| booked_rooms.include?(room.number) }
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
