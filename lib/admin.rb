module Hotel
  class Admin
    #Wave 1

    def initialize
      # As an administrator, I can access the list of all of the rooms in the hotel
      @rooms = Hotel::Rooms.create_rooms # {ID : RoomObject}
    end

    # As an administrator, I can access the list of reservations for a specific date
    def reservations_at_date(date)
      # takes in a date
      # returns an array of reservations that have the date in their range
            # date >= check_in_date < check_out_date
    end

    # As an administrator, I can reserve a room for a given date range
    def reserve(check_in, check_out)
      # Given check_in and check_out (Date objects)
      # Create a Reservation with those dates + assign a room
    end

    # As an administrator, I can get the total cost for a given reservation
    def total_cost(reservation)
      # Get how many days a customer is staying (check_out - check_in)
      # Multiply by room cost
      # return
    end

  end
end
