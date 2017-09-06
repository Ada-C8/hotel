# require 'date'

module BookingSystem
  class Hotel
    attr_reader :rooms, :reservations

    def initialize
      # As an administrator, I can access the list of all of the rooms in the hotel
      # This will return all rooms that the hotel has
      @rooms = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
      @reservations = []
    end

    def create_reservation(check_in, check_out)
      # As an administrator, I can reserve a room for a given date range
      # Date must be in date format
      # Should I create the date instance first?
      reservation = Reservation.new(@rooms, check_in, check_out)
      @reservations << reservation
      return @reservations
      # => RETURNS a SINGLE INSTANCE OF RESERVATION
    end

    def all_reservations_on(date) # UNAVAILABLE ROOMS
      # As an administrator, I can access the list of reservations for a specific date (single)
      date = Date.parse(date) # Figure out how to parse this
      current_reservations = []
      # print @reservations.length
      @reservations.each do |reservation| # Do I need an array date range for this method?
        if reservation.stay_dates.include? date
          current_reservations << reservation
        end
      end
      #   # if date >= reservation.check_in && date <= reservation.check_out
      #   end
      #   # If the date matches, return all instances of Reservations as an ARRAY
      # end
      return current_reservations
    end

    # def check_avail_rooms_for(dates) # WAVE 2
    #   rooms_available = []
    #
    #   # As an administrator, I can view a list of rooms that are not reserved for a given date range
    #   # This will look through @reservations and check for rooms that do not have the requested date.
    #   # Return all room numbers from the @rooms array that were not found in the check and return all available rooms as an array
    # end

  end # Class
end # BookingSystem
