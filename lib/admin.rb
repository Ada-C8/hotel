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

    # As an administrator, I can reserve an available room for a given date range
    def reserve(check_in, check_out, room_num)
      # Create a Reservation with those dates + assign a room
      if check_in.class != Date || check_out.class != Date
        raise ArgumentError.new("Date objects were not passed into the method")
      end
      raise ArgumentError.new("Passed in invalid dates.") if check_out <= check_in
      raise ArgumentError.new("Room number passed is invalid.") if room_num > NUM_OF_ROOMS || room_num < 0

      #Check all reservations if it can be made
      @reservations.each do |reservation|
        if reservation.room.room_number == room_num && reservation.overlap?(check_in, check_out)
          raise ArgumentError.new("There's overlap with this reservation and an existing reservation's date and room number")
        end
      end

      associated_room = find_room(room_num)
      new_reservation = Hotel::Reservation.new(check_in, check_out, associated_room)
      @reservations << new_reservation
      new_reservation.change_availability(false)
      return new_reservation
    end

    # As an administrator, I can access the list of reservations for a specific date
    def reservations_at_date(date)
      # returns an array of reservations that have the given date in their range
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

    # returns a Room object if it finds it, nil otherwise
    def find_room(room_number)
      return @rooms.detect { |r| r.room_number == room_number}
    end


    # As an administrator, I can view a list of rooms that are not reserved for a given date range
    def available_rooms_in_date_range(date1, date2)
      if date1.class != Date || date2.class != Date
        raise ArgumentError.new("Date objects were not passed into the method")
      end
      raise ArgumentError.new("Dates are in invalid order") if date2 < date1

      # Get all reservation objects that fall within the date range
      reservations_at_date_range = @reservations.select do |reservation|
        reservation.overlap?(date1, date2)
      end
      # Get those reservation's associated room's numbers
      # turns array of Reservations into array of room numbers
      reservations_at_date_range.map!{|reservation| reservation.room.room_number}
      reserved_room_numbers_at_date_range = reservations_at_date_range.uniq
      # Get the room numbers that are not those numbers
      available_room_numbers_at_date_range = (1...NUM_OF_ROOMS).select{|room_number| !reserved_room_numbers_at_date_range.include?(room_number)}
      # Get the actual Room objects associated with those numbers
      rooms_at_date_range = available_room_numbers_at_date_range.map{|room_number| find_room(room_number)}
      return rooms_at_date_range
    end

  end
end
