require_relative 'check_user_input'

module BookingSystem
  class Hotel
    include BookingSystem::CheckUserInput

    class UnavailableRoomError < StandardError
    end
    class UnavailableBlockError < StandardError
    end

    DEFAULT_ROOM_PRICE = 200
    DISCOUNT_RATE_BLOCK_ROOM = 0.15

    attr_reader :rooms, :all_single_reservations, :all_block_reservations, :all_blocks

    def initialize
      @rooms = (1..20).to_a
      @all_single_reservations = []
      @all_block_reservations = []
      @all_blocks = []
    end

    def make_single_reservation(room, check_in, check_out, price = DEFAULT_ROOM_PRICE)
      room_available = room_available?(room, check_in, check_out)

      CheckUserInput.price(price)

      if room_available
        reservation = BookingSystem::Reservation.new(room, check_in, check_out, price)
        @all_single_reservations << reservation

        return reservation
      else #false
        raise UnavailableRoomError.new("Room #{room} is not available for those dates - #{check_in.to_s} to #{check_out.to_s}")
      end
    end

    def block_reservation(block_id, room, check_in, check_out, price = DEFAULT_ROOM_PRICE, discount_rate = DISCOUNT_RATE_BLOCK_ROOM)
      CheckUserInput.integer(room)
      CheckUserInput.between_1_20(room)
      CheckUserInput.price(price)

      #check that there are any blocks
      if @all_blocks.empty?
        raise UnavailableBlockError.new("There are no blocks currently in the system")
      end

      #check that there is a matching block_id
      block_id_match = @all_blocks.select {|block| block.block_id_match?(block_id)}

      if block_id_match == false
        raise UnavailableBlockError.new("There is no block with this ID: #{block_id}")
      end
      #
      # block_id_match = @all_blocks.all? {|block| block.block_id_match?(block_id)}
      #
      # if block_id_match == false
      #   raise UnavailableBlockError.new("There is no block with this ID: #{block_id}")
      # end

      # block_id_match = @all_blocks.select {|block| block.block_id == block_id}

      if block_id_match.empty?
        raise UnavailableBlockError.new("There is no block with this ID: #{block_id}")
      end

      #check that room requested is available in block
      new_block_reservation = nil
      block_id_match.each do |block|
        #if a match make block reservation
        #remove room from availablity in block
        if block.rooms_available.include?(room)
          new_block_reservation = BookingSystem::Reservation.new(room, check_in, check_out, price, discount_rate)
          block.remove_reserved_room_from_availability(room)
          @all_block_reservations << new_block_reservation
          return new_block_reservation
        else
          raise UnavailableRoomError.new("Room #{room} in this block is not available")
        end
      end
    end

    def block_off_a_block(number_of_rooms, check_in, check_out)
      CheckUserInput.integer(number_of_rooms)
      CheckUserInput.between_1_5(number_of_rooms)

      all_available_rooms = @rooms.select {|room_num| room_available?(room_num, check_in, check_out)}

      #check that there are enough rooms available to fill request
      if all_available_rooms.length < number_of_rooms
        raise UnavailableBlockError.new("There is not enough rooms available to fill block request of ##{number_of_rooms} for dates #{check_in} to #{check_out}")
      end

      #select first available rooms to fill request
      rooms_in_block = all_available_rooms[0..(number_of_rooms - 1)]

      #block off a block by instantiating Block
       new_block = BookingSystem::Block.new(number_of_rooms, rooms_in_block, check_in, check_out)

       @all_blocks << new_block

      return new_block
    end

    def reservations_for_specific_date(date)
      single_reservations = @all_single_reservations.select {|res| res.all_reservation_dates.include?(date)}

      block_reservations = @all_block_reservations.select {|res| res.all_reservation_dates.include?(date)}

      all_reservations = single_reservations + block_reservations

      return all_reservations
    end

    def available_rooms(check_in, check_out)
      available_rooms = (1..20).to_a
      requested_date_range = DateRange.new(check_in, check_out).all_reservation_dates

      @all_single_reservations.each do |res|
        same_dates = requested_date_range & res.all_reservation_dates
        if same_dates.any?
          available_rooms.delete(res.room)
        end
      end

      @all_blocks.each do |block|
        same_dates = requested_date_range & block.all_reservation_dates
        if same_dates.any?
          block.rooms_in_block.each do |room|
            available_rooms.delete(room)
          end
        end
      end

      return available_rooms
    end

    private
    #check if room is available for selected dates
    def room_available?(room, check_in, check_out)
      CheckUserInput.integer(room)
      CheckUserInput.between_1_20(room)
      new_date_range_ob = DateRange.new(check_in, check_out)

      #check all single reservations
      @all_single_reservations.each do |reservation|
        if reservation.room == room && reservation.overlap?(new_date_range_ob)
          return false #=> room not available
        end
      end

      #check booked blocks
      #find booked blocks that include room number
      @all_blocks.each do |block|
        if block.rooms_in_block.include?(room) && block.overlap?(new_date_range_ob)
          return false #=> room not available
        end
      end

      return true
    end

  end
end
