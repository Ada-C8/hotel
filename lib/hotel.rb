# require 'date'

module BookingSystem
  class Hotel
    attr_reader :rooms, :reservations

    def initialize
      @rooms = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
      @reservations = []
    end

    def create_reservation(check_in, check_out)
      # Input validation method
      #TODO: Need a valid input method here for date input to be parsed in date range if not, raise an argument error
      #TODO: check_in date needs to be less than check_out date
      available_rooms = check_avail_rooms_for(check_in, check_out) # Returns array of all available rooms
      # if available_rooms.empty?
      #   puts "No room available for your requested dates. Please choose another date"
      #   return
      # end
      assigned_room = available_rooms[0]
      reservation = Reservation.new(assigned_room, check_in, check_out)
      @reservations << reservation
    end

    # I can access the list of reservations for a specific date (single)
    def all_reservations_on(date) # UNAVAILABLE ROOMS
      current_reservations = []
      date = Date.parse(date)
      @reservations.each do |reservation|
        if date >= reservation.check_in && date < reservation.check_out
          current_reservations << reservation
        end
      end
      return current_reservations
    end

    def check_avail_rooms_for(next_check_in, next_check_out) # WAVE 2
      next_reservation = DateRange.new(next_check_in, next_check_out)
      existing_booked_rooms = next_reservation.overlap?(@reservations)
      if existing_booked_rooms.empty?
        return @rooms
      else
        return @rooms - existing_booked_rooms
      end
    end

    # private
    #
    # def valid_input?
    #
    #
    # end

  end # Class
end # BookingSystem
