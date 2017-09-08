require 'pry'
module Hotel
  class Admin
    #Wave 1
    attr_reader :rooms, :reservations

    def initialize
      # As an administrator, I can access the list of all of the rooms in the hotel
      @rooms = Hotel::Room.all # {ID : RoomObject}
      @reservations = [] # key: reservation, value: hash
    end

    # As an administrator, I can reserve a room for a given date range
    def reserve(check_in, check_out, room_num)
      # Create a Reservation with those dates + assign a room
      if check_in.class != Date || check_out.class != Date
        raise ArgumentError.new("Date objects were not passed into the method")
      end
      raise ArgumentError.new("Passed in invalid dates.") if check_out <= check_in
      raise ArgumentError.new("Room number passed is invalid.") if room_num > NUM_OF_ROOMS || room_num < 0

      #Check all reservations if it can be made
      @reservations.each do |reservation|
        if reservation.overlap?(check_in, check_out, room_num)
          raise ArgumentError.new("There's overlap with this reservation and an existing reservation's date and room number")
        end
      end

      associated_room = find_room(room_num)
      associated_room.change_availability(true) # only really useful for those with overlapping checkout and checkin :/
      new_reservation = Hotel::Reservation.new(check_in, check_out, associated_room)
      @reservations << new_reservation
      return new_reservation
    end

    # As an administrator, I can access the list of reservations for a specific date
    def reservations_at_date(date)
      # takes in a date
      # returns an array of reservations that have the date in their range
            # date >= check_in_date < check_out_date
      list_of_reservations_at_date = @reservations.select do |reservation|
        reservation.check_in <= date && reservation.check_out > date
      end
      return list_of_reservations_at_date
    end

    # As an administrator, I can get the total cost for a given reservation
    def total_cost(reservation)
      if reservation.class != Hotel::Reservation
        raise ArgumentError.new("Reservation not passed into total_cost method")
      end
      # Get how many days a customer is staying (check_out - check_in)
      total_days = (reservation.check_out - reservation.check_in).to_i
      # Multiply by room cost, return
      return reservation.room.cost * total_days
    end

    # find a Room object that's available
    # nil
    def find_room(room_number)
      return @rooms.detect { |r| r.room_number == room_number}
    end


  end
end
