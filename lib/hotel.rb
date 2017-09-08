module BookingSystem
  class Hotel

    class UnavailableRoomError < StandardError
    end

    attr_reader :rooms, :all_single_reservations, :all_block_reservations
    def initialize
      @rooms = (1..20).to_a
      @all_single_reservations = []
      @all_block_reservations = []
    end

    def check_user_input(user_input)
      unless user_input.class == Integer
        raise BookingSystem::Reservation::InvalidRoomError.new("Invalid room error, must enter an integer between 1-20 (given: #{user_input})")
      end

      unless user_input > 0 && user_input < 21
        raise BookingSystem::Reservation::InvalidRoomError.new("Invalid room error, must enter an integer between 1-20 (given: #{user_input})")
      end
    end

    def make_reservation(room, check_in, check_out)
      #call room_available? method
      room_available = room_available?(room, check_in, check_out)

      if room_available == true
        reservation = BookingSystem::Reservation.new(room, check_in, check_out)
        @all_single_reservations << reservation

        return reservation
      else #false
        raise UnavailableRoomError.new("Room #{room} is not available for those dates - #{check_in.to_s} to #{check_out.to_s}")

      end
    end

    def block_reservation(number_of_rooms, check_in, check_out)
      #check which rooms are available for date range
      #https://stackoverflow.com/questions/25168005/how-to-select-the-first-n-elements-from-ruby-array-that-satisfy-a-predicate

      check_user_input(number_of_rooms)

      # unless number_of_rooms.class == Integer
      #   raise BookingSystem::Reservation::InvalidRoomError.new("Invalid room error, must enter an integer between 1-20 (given: #{number_of_room})")
      # end
      #
      # unless number_of_rooms > 0 && room < 21
      #   raise BookingSystem::Reservation::InvalidRoomError.new("Invalid room error, must enter an integer between 1-20 (given: #{number_of_rooms})")
      # end

      all_available_rooms = []
      @rooms.each do |room_num|
        if room_available?(room_num, check_in, check_out)
          all_available_rooms << room_num
        end
      end

      #check that there are enough rooms available to fill request
      if all_available_rooms.length < number_of_rooms
        raise UnavailableRoomError.new("Requested too many rooms. Requested #{number_of_rooms}; only #{all_available_rooms.length} available for date range selected")
      end

      #select first available rooms to fill request
      rooms_for_block = all_available_rooms[0..(number_of_rooms - 1)]

      #make block reservation
       new_block_reservation = BookingSystem::Block.new(number_of_rooms, rooms_for_block, check_in, check_out)

       @all_block_reservations << new_block_reservation

      return new_block_reservation
    end

    def reservations_for_specific_date(date)
      reservations_for_specific_date = []
      @all_single_reservations.each do |res|
        if res.reservation_dates.include?(date)
          reservations_for_specific_date << res
        end
      end

      return reservations_for_specific_date
    end

    def available_rooms(check_in, check_out)
      available_rooms = (1..20).to_a
      requested_date_range = DateRange.new(check_in, check_out).all_reservation_dates

      @all_single_reservations.each do |res|
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

      # unless room.class == Integer
      #   raise BookingSystem::Reservation::InvalidRoomError.new("Invalid room error, must enter an integer between 1-20 (given: #{room})")
      # end
      #
      # unless room > 0 && room < 21
      #   raise BookingSystem::Reservation::InvalidRoomError.new("Invalid room error, must enter an integer between 1-20 (given: #{room})")
      # end

      check_user_input(room)

      all_res_for_room = @all_single_reservations.select {|res| res.room == room}

      requested_date_range = DateRange.new(check_in, check_out).all_reservation_dates

      all_dates_for_room = []
      all_res_for_room.each do |res|
        all_dates_for_room += res.reservation_dates
      end

      #compare all reservation dates for the room with the requested date range
      same_dates = requested_date_range & all_dates_for_room

      #check block reservations
      all_blocks_with_room = []
      @all_block_reservations.each do |block_res|
        #find block reservations that include room number
        if block_res.all_room_numbers.include?(room)
          all_blocks_with_room << block_res
        end
      end
      #check for overlapping dates
      all_blocks_with_room.each do |block_res|
        overlap = block_res.date_range & requested_date_range
        if overlap.length > 0
          return false
        end
      end

      if same_dates.length > 0
        return false
      end

      return true

    end

  end
end
