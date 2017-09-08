module Hotel
  class HotelClass
    attr_reader :rooms, :reservations
    def initialize
      # access the list of all of the rooms in the hotel
      @rooms = (1..20).to_a
      @reservations = []
    end

    def reserve_room(room_id, check_in, check_out)
      # reserve a room for a given date range
      new_reservation = Hotel::Reservation.new(room_id, check_in, check_out)
      reservations << new_reservation
    end

    def access_reservations#(date)
      # access the list of reservations for a specific date
      # loop over @reservations.date_range
      # if date_range includes passed in date
      # return reservations
      return reservations
    end

    def view_avaiable_rooms(date_range)
      # view a list of rooms that are not reserved for a given date range
      # loop thru reservations.date_range to see if it include the date_range passed in, if not return room_ids

    end

  end
end
