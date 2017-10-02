
module Hotel
  class Hotel
    class InvalidRoomError < StandardError ; end
    attr_reader :reservations, :rooms

    def initialize
      @reservations = []
      @rooms = (1..20).to_a
    end # initialize

    def available_rooms(date_range)
      reservations = @reservations.reject do |reservation| # removes rooms already booked
        !reservation.dates.overlap?(date_range)
      end
      reserved_rooms = reservations.map do |reservation| # converts each reservation in reservations into its room number
        reservation.room
      end
      return @rooms.reject do |room| # returns the available room numbers by removing reserved rooms from the @rooms list
        reserved_rooms.include?(room)
      end
    end # end available_rooms

    def add_reservation(reservation)
      available = available_rooms(reservation.dates)
      if !available.include?(reservation.room)
        raise InvalidRoomError.new('This room has already been booked') # tests if room has already been booked
      else
        @reservations << reservation
      end
    end # end add_reservation

    def all_reservations
      return @reservations.map do |reservation|
        reservation.pretty_print
      end
    end # end all_reservations

    def list_on_date(date)
      reservations = @reservations.select do |reservation|
        reservation.dates.check_in <= date && date <= reservation.dates.check_out
      end
      return reservations.map do |reservation|
        reservation.pretty_print
      end
    end # end on_date
  end # end class
end # end module
