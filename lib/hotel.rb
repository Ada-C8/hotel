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

    def all_rooms_in_hotel
      return @rooms
    end
    # As an administrator, I can reserve a room for a given date range
    def create_reservation(check_in, check_out)
      #TODO: Need a valid input method here for date input to be parsed in date range if not, raise an argument error
      #TODO: check_in date needs to be less than check_out date
      # begin
      room_num = check_avail_rooms_for(check_in, check_out)
      assigned_room = room_num[0]
      reservation = Reservation.new(assigned_room, check_in, check_out)
      # NEED TO RETURN ONLY ONE INSTANCE AFTER ALL THE CHECKS OF DATE AND ROOM NUMBER HAVE BEEN MADE
      @reservations << reservation
      # => RETURNS a SINGLE INSTANCE OF RESERVATION
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

    def check_avail_rooms_for(next_check_in, check_out) # WAVE 2
      booked_room_num = []
      next_check_in = Date.parse(next_check_in)
      @reservations.each do |reservation|
        if next_check_in >= reservation.check_in && next_check_in <= reservation.check_out - 1
          booked_room_num << reservation.room_num
        end
      end
      available_rooms = booked_room_num - @rooms
      return available_rooms
    end

    # As an administrator, I can view a list of rooms that are not reserved for a given date range
    # As an administrator, I can reserve an available room for a given date range

  end # Class
end # BookingSystem
