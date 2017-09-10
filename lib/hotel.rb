# require 'date'

module BookingSystem
  class Hotel
    attr_reader :rooms, :reservations, :block_reservations

    def initialize
      # I can access the list of all of the rooms in the hotel
      @rooms = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
      @reservations = []
      @block_reservations = []
    end
    # I can reserve a room for a given date range
    def create_reservation(check_in, check_out) # check_input(check_in, check_out) FOR UI
      available_rooms = check_avail_rooms_for(check_in, check_out) # Returns array of all available rooms
      if rooms_available?(available_rooms)
        assigned_room = available_rooms[0] # Assign the first available room
        reservation = Reservation.new(assigned_room, check_in, check_out)
        # update_price(reservation)
        # I need to be able to initialize the reservation with the caluclated cost
        @reservations << reservation
      end
    end
    # I can create a block of rooms
    def reserve_block(reserved_for, check_in, check_out, num_of_rooms)
      available_rooms = check_avail_rooms_for(check_in, check_out) # This is converted to a date object
      if rooms_available?(available_rooms) # Will raise an ArgumentError for UI
        reserved_room_nums = available_rooms[0..num_of_rooms - 1] # Takes the first 5 rooms from all available rooms
        new_block = Block.new(reserved_for, check_in, check_out, reserved_room_nums)
        # Return only one block reservation and pass it into the @reservations array so that they cannot access the rooms
        @reservations << new_block
        @block_reservations << new_block
        return new_block # Returns all reserved rooms for a block from 1 to 5 as an array
      end
    end

    def reserve_room_in_block(reserved_name, num_to_book)
      found_block = find_requested_block(reserved_name)  # Returns all available room numbers for requested block
      avail_rooms = avail_rooms_in_block?(reserved_name) # Check which room numbers are available in the block
      now_reserved_in_block = avail_rooms[0..num_to_book - 1] # Book number of requested rooms in the current block
      remaining_rooms = avail_rooms - now_reserved_in_block # Remaining rooms in requested block
      found_block.update_block_rooms(remaining_rooms, now_reserved_in_block) # Updates available vs reserved rooms in the requested block
    end

    def avail_rooms_in_block?(reserved_name)
      found_block = find_requested_block(reserved_name)
      return found_block.avail_block_rooms
    end # def
    # I can access the list of reservations for a specific date
    def all_reservations_on(date)
      current_reservations = []
      date = Date.parse(date)
      @reservations.each do |reservation|
        current_reservations << reservation if date >= reservation.check_in && date < reservation.check_out
      end
      return current_reservations
    end
    # I can view a list of rooms that are not reserved for a given date range
    def check_avail_rooms_for(next_check_in, next_check_out) # WAVE 2
      next_reservation = DateRange.new(next_check_in, next_check_out)
      existing_booked_rooms = next_reservation.overlap?(@reservations)
      existing_booked_rooms.empty? ? @rooms : @rooms - existing_booked_rooms
    end

    def rooms_available?(available_rooms)
      if available_rooms.empty?
        raise ArgumentError.new("No room available for your requested dates. Please choose another date") # Raise to UI
      else
        return true
      end
    end # def

    def find_requested_block(reserved_name)
      block_found = nil
      @block_reservations.each do |block|
        if block.reserved_for == reserved_name
          block_found = block
          return block
        end
      end
      raise ArgumentError.new("Reservation for your requested block was not found. Please try again.") if block_found == nil
    end # def

    # def update_price(reservation)
    #   reservation.calculate_cost
    # end

  end # Class
end # BookingSystem
