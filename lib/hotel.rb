module Hotel
  class HotelClass
    attr_reader :rooms, :reservations
    def initialize
      # access the list of all of the rooms in the hotel
      @rooms = (1..20).to_a
      @reservations = []
    end

    def reserve_room(check_in, check_out)
      # reserve a room for a given date range
      new_reservation = Hotel::Reservation.new(1, check_in, check_out)
      reservations << new_reservation
    end

    def is_available?(room, date)
      # loop through @rooms
      return true
    end



    def access_reservations
      # access the list of reservations for a specific date
      # returns @reservations
    end



  end
end
