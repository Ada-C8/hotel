require 'pry'
module Hotel
  class Admin
    #Wave 1
    attr_reader :rooms, :reservations

    def initialize
      # As an administrator, I can access the list of all of the rooms in the hotel
      @rooms = initialize_rooms # {ID : RoomObject}
      @reservations = []
    end

    # As an administrator, I can reserve a room for a given date range
    def reserve(check_in, check_out, room_num)
      # Given check_in and check_out (Date objects)...
      # Create a Reservation with those dates + assign a room
              #(.detect Enumerable would be useful since you just need the first instance where the room is avaiable)

      #TODO: what should an unsuccessful "reservation" return?
      new_reservation = Hotel::Reservation.new(check_in, check_out, room_num, self) #successfully creates Reservation Object
      raise ArgumentError.new("Room number does not exist.") if new_reservation == nil
      @reservations << new_reservation
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

    def find_room(room_num)
      return @rooms.detect { |r| r.room_num == room_num }
    end

    private

    def initialize_rooms
      room_array = []
      NUM_OF_ROOMS.times do |i|
        room_array << Hotel::Room.new(i + 1) # Hotel Room Numbers start with 1, not 0
      end
      return room_array
    end

  end
end
