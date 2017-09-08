require_relative 'check_user_input'

module BookingSystem
  class Hotel
    include BookingSystem::CheckUserInput

    class UnavailableRoomError < StandardError
    end

    attr_reader :rooms, :all_single_reservations, :all_blocks
    def initialize
      @rooms = (1..20).to_a
      @all_single_reservations = []
      @all_blocks = []
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

    def block_reservation(room, check_in, check_out)
      CheckUserInput.integer(room)
      CheckUserInput.between_1_20(room)

      requested_date_range = DateRange.new(check_in, check_out).all_reservation_dates

      #check that room and date range match a block reservation

      new_block_reservation = nil

      @all_blocks.each do |block|
        #if a match make block reservation
        #remove room from availablity in block
        if block.date_range == requested_date_range && block.rooms_available.include?(room)
          new_block_reservation = BookingSystem::BlockReservation.new(room, check_in, check_out)
          block.remove_reserved_room_from_availability(room)
          return new_block_reservation
        else
          raise UnavailableRoomError.new("Room #{room} in this block is not available for those dates - #{check_in.to_s} to #{check_out.to_s}")
        end
      end
    end

    def block_off_a_block(number_of_rooms, check_in, check_out)
      CheckUserInput.integer(number_of_rooms)
      CheckUserInput.between_1_5(number_of_rooms)

      #check which rooms are available for date range
      #https://stackoverflow.com/questions/25168005/how-to-select-the-first-n-elements-from-ruby-array-that-satisfy-a-predicate
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
      rooms_in_block = all_available_rooms[0..(number_of_rooms - 1)]

      #block off a block by instantiating Block
       new_block = BookingSystem::Block.new(number_of_rooms, rooms_in_block, check_in, check_out)

       @all_blocks << new_block

      return new_block
    end

    def reservations_for_specific_date(date)
      reservations_for_specific_date = []
      @all_single_reservations.each do |res|
        if res.reservation_dates.include?(date)
          reservations_for_specific_date << res
        end
      end

      #TODO: BLOCK RESERVATIONS

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

      #TODO: BLOCKS

      return available_rooms
    end

    private

    #check if room is available for selected dates
    def room_available?(room, check_in, check_out)

      CheckUserInput.integer(room)
      CheckUserInput.between_1_20(room)

      all_res_for_room = @all_single_reservations.select {|res| res.room == room}

      requested_date_range = DateRange.new(check_in, check_out).all_reservation_dates

      all_dates_for_room = []
      all_res_for_room.each do |res|
        all_dates_for_room += res.reservation_dates
      end

      #compare all reservation dates for the room with the requested date range
      same_dates = requested_date_range & all_dates_for_room

      #check booked blocks
      all_blocks_with_room = []
      @all_blocks.each do |block|
        #find booked blocks that include room number
        if block.rooms_in_block.include?(room)
          all_blocks_with_room << block
        end
      end
      #check for overlapping dates
      all_blocks_with_room.each do |block|
        overlap = block.date_range & requested_date_range
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
