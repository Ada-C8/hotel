require_relative 'reservation'

module Hotel
  class Hotel
    attr_reader :rooms, :reservations, :reserved
    def initialize
      # access the list of all of the rooms in the hotel
      @rooms = (1..20).to_a
      @reservations = []
      @reserved = []
    end

    def view_available_rooms(check_in, check_out)
      # view a list of rooms that are not reserved for a given date range
      # loop thru reservations.date_range to see if it include the date_range passed in, if not return room_ids

      available_rooms = @rooms
      reserved_rooms = []

      reservations.each do |reservation|
        if reservation.date_range.overlap?(check_in, check_out)
          reserved << reservation
        end
      end

      reserved.each do |reserved_room|
        reserved_rooms << reserved_room.room_id
      end

      available_rooms -= reserved_rooms
      return available_rooms
    end

    def reserve_room(room_id, check_in, check_out)
      unless @rooms.include?(room_id)
        raise ArgumentError.new("That room does not exist")
      end

      unless view_available_rooms(check_in, check_out).include?(room_id)
        raise ArgumentError.new("Room #{room_id} is not available for those dates")
      end

      new_reservation = Reservation.new(room_id, check_in, check_out)
      reservations << new_reservation

      return new_reservation
    end

    def access_reservations(date)
      # access the list of reservations for a specific date
      # loop over @reservations.date_range
      # if date_range includes passed in date
      # return reservations

      valid_reservations = []

      reservations.each do |reservation|
        # broken
        # the if statement seems to be always returning false and what is being returned from reservations are
        # therefore nothing is being pushed on valid_reservations
        if (reservation.date_range.check_in..reservation.date_range.check_out).include?(date)
          valid_reservations << reservation
        end
      end
      return valid_reservations
    end

  end
end
