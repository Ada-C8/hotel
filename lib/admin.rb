require 'pry'
module Hotel
  class Admin
    #Wave 1
    attr_reader :rooms, :reservations_rooms_hash

    def initialize
      # As an administrator, I can access the list of all of the rooms in the hotel
      @rooms = Hotel::Room.all # {ID : RoomObject}
      @reservations_rooms_hash = {} # key: reservation, value: hash
    end

    # As an administrator, I can reserve a room for a given date range
    def reserve(check_in, check_out, room_num)
      # Given check_in and check_out (Date objects)...
      # Create a Reservation with those dates + assign a room
              #(.detect Enumerable would be useful since you just need the first instance where the room is avaiable)
      raise ArgumentError.new("Passed in invalid dates.") if check_out <= check_in
      raise ArgumentError.new("Room number passed is invalid.") if room_num > NUM_OF_ROOMS || room_num < 0

      associated_room = find_room(room_num)
      new_reservation = Hotel::Reservation.new(check_in, check_out, associated_room)
      @reservations_rooms_hash.merge!({new_reservation => associated_room})
      return new_reservation
    end

    # As an administrator, I can access the list of reservations for a specific date
    def reservations_at_date(date)
      # takes in a date
      # returns an array of reservations that have the date in their range
            # date >= check_in_date < check_out_date
    end

    # As an administrator, I can get the total cost for a given reservation
    def total_cost(reservation)
      # Get how many days a customer is staying (check_out - check_in)
      # Multiply by room cost
      # return
    end

    #find a Room object that's available
    def find_room(room_num)
      return @rooms.detect { |r| r.available == true }
    end


  end
end
