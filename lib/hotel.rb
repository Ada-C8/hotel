module My_Hotel
  #to change room prices, change the values of ROOMS
  ROOMS = {1 => 200,
    2 => 200,
    3 => 200,
    4 => 200,
    5 => 200,
    6 => 200,
    7 => 200,
    8 => 200,
    9 => 200,
    10 => 200,
    11 => 200,
    12 => 200,
    13 => 200,
    14 => 200,
    15 => 200,
    16 => 200,
    17 => 200,
    18 => 200,
    19 => 200,
    20 => 200
  }
  class Hotel #keeps track of all the reservations and all the blocks.
    attr_reader :rooms, :all_reservations, :all_blocks

    def initialize
      @rooms = ROOMS
      @all_reservations = []
      @all_blocks =[]
    end

    # can be used for "As an administrator, I can access the list of
    #all of the rooms in the hotel"
    def display_rooms
      ROOMS.keys
    end

    #Can be used for "As an administrator, I can get the total cost
    # for a given reservation" Or, you could just do reservation.cost
    def get_cost(reservation)
      reservation.cost
    end

    def date_range(first_night, last_night)
      if first_night > last_night
        raise ArgumentError.new("The first night of this booking occurs after the last night date. First night:#{first_night} Last night:#{last_night}")
      end
      if first_night != last_night
        nights = (first_night..last_night)
      else
        nights = []
        nights << first_night
      end
      return nights
    end

    #can be used for "As an administrator, I can reserve an available room for a given date range"
    def make_reservation(first_night, last_night=first_night)
      nights = date_range(first_night, last_night)
      rooms_avail = unreserved_and_unblocked(nights)
      if rooms_avail == {}
        raise ArgumentError.new("Can't make reservation, there are no rooms available for those dates: #{@nights_booked}")
      end
      new_reservation = My_Hotel::Reservation.new(nights)
      new_reservation.create_booking(@all_reservations, rooms_avail)
      @all_reservations << new_reservation
      return new_reservation
    end

    #can be used for "As an administrator, I can create a block of rooms"
    def make_block(first_night, last_night=first_night, array_of_rooms, discount)
      nights = date_range(first_night, last_night)
      check_block_array(array_of_rooms, nights)
      new_block = My_Hotel::Block.new(nights, array_of_rooms, discount)
      new_block.create_booking(@all_blocks)
      @all_blocks << new_block
      new_block
    end

    #can be used for "As an administrator, I can reserve a room from
    #within a block of rooms"
    def make_reservation_in_block(block_id)
      current_block = find_by_block_id(block_id)
      rooms_avail = rooms_available_in_block(block_id)
      new_reservation = My_Hotel::Reservation.new(current_block.nights_held)
      new_reservation.create_booking(@all_reservations, rooms_avail, current_block.discount, block_id)
      @all_reservations << new_reservation
      return new_reservation
    end

    def check_block_array(array_of_rooms, nights)
      if array_of_rooms.length > 5
        raise ArgumentError.new "Only accepts blocks of 5 rooms or less, a block of #{array_of_rooms.length} was entered."
      end
      available = unreserved_and_unblocked(nights)
      available = available.keys
      if array_of_rooms - available != []
        raise ArgumentError.new "Those rooms (#{array_of_rooms}) were not available for those dates (#{nights})."
      end
    end

    #can be used for "As an administrator, I can check whether a given block has any rooms available"
    def rooms_available_in_block(block_id)
      rooms_in_block = find_rooms_in_block(block_id)
      rooms_in_use = find_rooms_in_use_by_block_id(block_id)
      free_room_numbers = rooms_in_block - rooms_in_use
      free_rooms = {}
      free_room_numbers.each do |number|
        free_rooms[number] = ROOMS[number]
      end
      free_rooms
    end


    #These can be used for "As an administrator, I can view a list
    # of rooms that are not reserved for a given date range"
    # Given a range of nights, returns a hash with all the
    # rooms available over the entire stay
    def unreserved_and_unblocked(nights)
      free_rooms = ROOMS.dup
      if nights.class == Date
        nights = [nights]
      end
      nights.each do |date|
        list_reservations = find_reservations_by_date(date)
        if list_reservations != nil
          list_reservations.each do |reservation|
            free_rooms.delete(reservation.room_number)
          end
        end
        list_blocks = find_blocks_by_date(date)
        if list_blocks != nil
          list_blocks.each do |block|
            block.room_numbers.each do |room|
              free_rooms.delete(room)
            end
          end
        end
        return free_rooms
      end
    end


    #### Methods to find rooms in blocks ####
    def find_rooms_in_block(block_id)
      block = find_by_block_id(block_id)
      block.room_numbers
    end


    def find_rooms_in_use_by_block_id(block_id)
      rooms_in_use = []
      if find_by_block_id(block_id) == nil
        raise ArgumentError.new("Can not find block id #{block_id}")
      end
      @all_reservations.each do |reservation|
        if reservation.block_id == block_id
          rooms_in_use << reservation.room_number
        end
      end
      return rooms_in_use
    end

    ####Methods to find reservations####
    def find_by_reservation_id(reservation_id)
      return @all_reservations.select { |reservation| reservation.reservation_id  == reservation_id }[0]
    end

    #can be used for "As an administrator, I can access the list of
    # reservations for a specific date"
    def find_reservations_by_date(date)
      return @all_reservations.select { |reservation| reservation.contain?(date) }
    end

    ####Methods to find blocks ####
    def find_by_block_id(block_id)
      return @all_blocks.select { |block| block.block_id  == block_id }[0]
    end

    def find_blocks_by_date(date)
      return @all_blocks.select { |block| block.contain?(date)}
    end

  end
end
