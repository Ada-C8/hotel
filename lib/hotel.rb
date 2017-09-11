module Hotel
  class HotelClass
    attr_reader :rooms, :reservations, :date_range, :available_room_nums, :reserved, :reserved_room_nums
    def initialize
      # access the list of all of the rooms in the hotel
      @rooms = (1..20).to_a
      @reservations = []
      @available_room_nums = []
      @reserved = []
      @reserved_room_nums = []
    end

    def reserve_room(room_id, check_in, check_out)
      # reserve an available room for a given date range
      new_reservation = Hotel::Reservation.new(room_id, check_in, check_out)
      # if room_id is not reserved
      if !(reserved_room_nums.include?(room_id))
        reservations << new_reservation
      else
        # currently does not raise Error
        raise ArgumentError.new("That date range is unavailable.")
      end
    end

    def access_reservations
      # access the list of reservations for a specific date
      # loop over @reservations.date_range
      # if date_range includes passed in date
      # return reservations
      return reservations
    end

    def view_available_rooms(check_in, check_out)
      # view a list of rooms that are not reserved for a given date range
      # loop thru reservations.date_range to see if it include the date_range passed in, if not return room_ids
      reservations.each do |reservation|
        if reservation.date_range.overlap?(check_in, check_out)
          reserved << reservation
        end
      end
      reserved.each do |reserved_room|
        if !(reserved.include?(reserved_room.room_id))
          reserved_room_nums << reserved_room.room_id
        end
      end
      rooms.each do |room|
        if !(reserved_room_nums.include?(room))
          available_room_nums << room
        end
      end
      return available_room_nums
    end
  end
end
