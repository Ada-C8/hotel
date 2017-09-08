# require 'date'

module BookingSystem
  class Hotel
    attr_reader :rooms, :reservations, :block_reservations

    def initialize
      @rooms = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
      @reservations = []
      @block_reservations = []
    end

    def create_reservation(check_in, check_out)
      ######## TODO: Need a valid input method here for date input to be parsed in date range if not, raise an argument error
      ######## TODO: check_in date needs to be less than check_out date
      available_rooms = check_avail_rooms_for(check_in, check_out) # Returns array of all available rooms
      ######## TODO Raise argument error here
      # if available_rooms.empty?
      #   puts "No room available for your requested dates. Please choose another date"
      # end
      assigned_room = available_rooms[0]
      reservation = Reservation.new(assigned_room, check_in, check_out)
      @reservations << reservation
    end

    # As an administrator, I can create a block of rooms
    def reserve_block(reserved_for, check_in, check_out, num_of_rooms)
      # This is converted to a date object
      #TODO:
      available_rooms = check_avail_rooms_for(check_in, check_out)
      reserved_room_nums = available_rooms[0..num_of_rooms - 1] # Takes the first 5 rooms from all available rooms
      new_block = Block.new(reserved_for, check_in, check_out, reserved_room_nums)
      # Return only one block reservation and pass it into the @reservations array so that they cannot access the rooms
      @reservations << new_block
      @block_reservations << new_block
      return new_block # Returns all reserved rooms for a block from 1 to 5 as an array
    end

    # As an administrator, I can reserve a room from within a block of rooms
    def reserve_room_in_block(reserved_name, num_to_book)
      found_requested_block = nil
      @block_reservations.each do |block|
        if block.reserved_for == reserved_name
          found_requested_block = block
          # This is an array of all available rooms
        end
        ##########TODO: Raise ArgumentError if no name matches the block reservation
        ##########TODO: Raise argument error. Must be greater than one and less than the number of available rooms
      end
      # Returns all available room numbers for that block
      avail_rooms = avail_rooms_in_block?(reserved_name)
      # Book number of requested rooms in the current block
      now_reserved_in_block = avail_rooms[0..num_to_book - 1]
      remaining_rooms = avail_rooms - now_reserved_in_block
      ############ Run update in Block class here here ################
      puts "#{now_reserved_in_block} NOW RESERVED********"
      puts "#{remaining_rooms} REMAINING ROOMS ********"
      found_requested_block.update_block_rooms(remaining_rooms, now_reserved_in_block) # This is an array
    end

    def avail_rooms_in_block?(reserved_name)
      # Find block with the specific name it was reserved for
      @block_reservations.each do |block|
        if block.reserved_for == reserved_name
          return block.avail_block_rooms
          # This is an array of all available rooms
        end
        ##########TODO: Raise ArgumentError if no name matches the block reservation
      end
    end # def

    # I can access the list of reservations for a specific date (single)
    def all_reservations_on(date) # UNAVAILABLE ROOMS
      current_reservations = []
      date = Date.parse(date)
      @reservations.each do |reservation|
        if date >= reservation.check_in && date < reservation.check_out
          current_reservations << reservation
        end
      end
      return current_reservations
    end

    def check_avail_rooms_for(next_check_in, next_check_out) # WAVE 2
      next_reservation = DateRange.new(next_check_in, next_check_out)
      existing_booked_rooms = next_reservation.overlap?(@reservations)
      if existing_booked_rooms.empty?
        return @rooms
      else
        return @rooms - existing_booked_rooms
      end
    end

  end # Class
end # BookingSystem
