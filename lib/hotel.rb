module BookingSystem
  class Hotel
    attr_reader :rooms, :all_reservations

    def initialize
      # As an administrator, I can access the list of all of the rooms in the hotel
      # This will return all rooms that the hotel has
      @rooms = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
      @all_reservations = []
    end

    def make_reservation(check_in, check_out)
      # As an administrator, I can reserve a room for a given date range
      # This will make a new instance of the Reservation Class here
      # dates will be an array
      # This will return an instance of the reservation that was made and push it into the all_reservations array
    end

    def all_reservations_on(date) # UNAVAILABLE
      # Loop through @all_reservations and check the dates for each reservation
      # If the date matches, return the instances of reservations as an ARRAY
      # As an administrator, I can access the list of reservations for a specific date
    end

    def check_avail_rooms_for(dates) # WAVE 2
      # As an administrator, I can view a list of rooms that are not reserved for a given date range
      # This will look through @all_reservations and check for rooms that do not have the requested date.
      # Return all room numbers from the @rooms array that were not found in the check and return all available rooms as an array
    end

  end # Class
end # BookingSystem

# Write pseudocode
# Write test(s)
# Write code
# Commit
