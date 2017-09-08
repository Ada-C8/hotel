# [X]As an administrator, I can access the list of all of the rooms in the hotel
# As an administrator, I can reserve a room for a given date range
# As an administrator, I can access the list of reservations for a specific date
# [X] As an administrator, I can get the total cost for a given reservation

module BookingSystem
  class HotelAdmin

    attr_reader :hotel_rooms, :all_reservations

    def initialize
      #hotel admin knows all collection of reservations
      @all_reservations = []
      #hotel admin knows all rooms in hotel
      @hotel_rooms = BookingSystem::Room.all
    end

    def make_reservation(first_name, last_name, room_id, room_rate, start_date, end_date)

      # check if room is available based on date range
      raise ArgumentError.new("Dates conflict with room requested") if @all_reservations.any? { |reservation|
        reservation.room_id == room_id && start_date.between?(reservation.start_date, reservation.end_date) && start_date < reservation.end_date
      }
      # If the new reservation's start date exists in between the existing reservation's start and end dates, and does not land on its end date, then we reject the reservation.

      reservation = BookingSystem::Reservation.new(first_name, last_name, room_id, room_rate, start_date, end_date)
      #check if date range for room is available
      @all_reservations << reservation
    end

    # private

    #def generate_reservation_ids
    #end

    # def check_availability
    #
    #   # checks all_reservations for a room id, start, and end date
    #   # see if room id is in reservation list
    #   # if room is in reservation, check to see the dates of the reservation
    #   # if the range of dates overlap (using the Date gem) (not including the final date of the existing reservation)
    #   #   then return false
    #   # Otherwise, return true
    # end




  end#of_HotelAdmin_class
end#of_module_BookingSystem

=begin
Date notes:

<
source: https://stackoverflow.com/questions/3296539/comparision-of-date-in-ruby

.between?(start_date, end_date)
source: https://stackoverflow.com/questions/4521921/how-to-know-if-todays-date-is-in-a-date-range
=end
