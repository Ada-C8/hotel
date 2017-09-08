# [X]As an administrator, I can access the list of all of the rooms in the hotel
# As an administrator, I can reserve a room for a given date range
# As an administrator, I can access the list of reservations for a specific date
# [X] As an administrator, I can get the total cost for a given reservation

require 'date'
require 'date_range'
require_relative 'room'
require_relative 'Reservation'

module BookingSystem
  class HotelAdmin

    attr_reader :room_list, :reservation_list

    def initialize
      #hotel admin knows all collection of reservations
      @reservation_list = []
      #hotel admin knows all rooms in hotel
      @room_list = BookingSystem::Room.all
    end

    def reserve_room(first_name, last_name, room_id, room_rate, start_date, end_date)

      #check if date range for room is available
      reservation = BookingSystem::Reservation.new(first_name, last_name, room_id, room_rate, start_date, end_date)

      @reservation_list << reservation
    end

    # def check_availability
    #   # check if room is available based on date range
    #   raise ArgumentError.new("Dates conflict with room requested") if @all_reservations.any? { |reservation|
    #     reservation.room_id == room_id && start_date.between?(reservation.start_date, reservation.end_date) && start_date < reservation.end_date
    #   }
    #   # If the new reservation's start date exists in between the existing reservation's start and end dates, and does not land on its end date, then we reject the reservation.
    # end

    # private

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
