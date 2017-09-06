module BookingSystem
  class Hotel

    class UnavailableRoomError < StandardError
    end

    attr_reader :rooms, :all_reservations
    def initialize
      @rooms = (1..20).to_a
      @all_reservations = []
    end

    def make_reservation(room, check_in, check_out)
      #call room_available? method
      room_available = room_available?(room, check_in, check_out)

      if room_available == true
        reservation = BookingSystem::Reservation.new(room, check_in, check_out)
        @all_reservations << reservation

        return reservation
      else #false
        raise UnavailableRoomError.new("Room #{room} is not available for those dates - #{check_in.to_s} to #{check_out.to_s}")

      end
    end

    def reservations_for_specific_date(date)
      reservations_for_specific_date = []
      @all_reservations.each do |res|
        if res.reservation_dates.include?(date)
          reservations_for_specific_date << res
        end
      end

      return reservations_for_specific_date
    end

    def available_rooms(check_in, check_out)
      available_rooms = (1..20).to_a
      requested_date_range = DateRange.new(check_in, check_out).all_reservation_dates

      @all_reservations.each do |res|
        same_dates = requested_date_range & res.reservation_dates
        if same_dates.any?
          available_rooms.delete(res.room)
        end
      end

      return available_rooms
    end

    private

    #check if room is available for selected dates
    def room_available?(room, check_in, check_out)
      all_res_for_room = @all_reservations.select {|res| res.room == room}

      requested_date_range = DateRange.new(check_in, check_out).all_reservation_dates

      all_dates_for_room = []
      all_res_for_room.each do |res|
        all_dates_for_room += res.reservation_dates
      end

      #compare all reservation dates for the room with the requested date range
      same_dates = requested_date_range & all_dates_for_room

      if same_dates.length > 0
        return false
      end

      return true

    end

  end
end
