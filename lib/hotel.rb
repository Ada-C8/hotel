
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
      if first_night != last_night
        @nights = (first_night..last_night)
      else
        @nights = []
        @nights << first_night
      end
    end

    #can be used for "As an administrator, I can reserve an available room for a given date range"
    def make_reservation(first_night, last_night=first_night)
      nights = date_range(first_night, last_night)
      rooms_avail = find_continious_open_room(nights)
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
      available = find_continious_open_room(nights)
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

    #### Methods to find reserved and blocked rooms ####
    #These can be used for "As an administrator, I can view a list
    # of rooms that are not reserved for a given date range" --

    # Given a range of nights, it will return an array of hashes.
    # Each of the inner hashes contains all the room numbers ==>
    # and cost that are not reserved for one night.
    #There is one inner hash per night.
    def find_all_unreserved_rooms(nights)
      if nights.class == Date
        nights = [nights]
      end
      array_of_rooms = []
      nights.each do |night|
        reservations_on_date = find_reservations_by_date(night)
        free_rooms = ROOMS.dup
        reservations_on_date.each do |reservation|
          free_rooms.delete(reservation.room_number)
        end
        array_of_rooms << free_rooms
      end
      return array_of_rooms
    end

    # Given a range of nights, it will return an array of hashes.
    # Each of the inner hashes contains all the room numbers ==>
    # and cost that are not blocked for one night.
    # There is one inner hahs per night.
    def find_all_unblocked_rooms(nights)
      if nights.class == Date
        nights = [nights]
      end
      array_of_rooms = []
      nights.each do |night|
        blocks_on_date = find_blocks_by_date(night)
        free_rooms = ROOMS.dup
        blocks_on_date.each do |block|
          block.room_numbers.each do |room|
            free_rooms.delete(room)
          end
        end
        array_of_rooms << free_rooms
      end
      return puts array_of_rooms
    end

    # Given a range of nights, it calls the methods to find the
    # unblocked and unreserved rooms. It uses that information find
    # rooms that are available (unreserved and unblocked).
    # Returns an array of hashes.The inner hash has all the rooms
    # that are available on one night.
    # Their is one inner hash per night.
    def unreserved_and_unblocked(nights)
      if nights.class == Date
        nights = [nights]
      end
      unblocked = find_all_unblocked_rooms(nights)
      unreserved = find_all_unreserved_rooms(nights)
      available_over_range = []
      index = 0
      unblocked.each do |night|
        free_on_night = {}
        20.times do |i|
          check = unblocked[index].has_key?(i+1) && unreserved[index].has_key?(i+1)
          if check
            free_on_night[i+1] = ROOMS[i+1]
          end
        end
        index = index + 1
        available_over_range << free_on_night
      end
      return available_over_range
    end

    #Given a range of nights it calls the method
    # unreserved_and_unblocked,
    #to find all the rooms that are free over the date range.
    #It returns a hash of the rooms that are open over the entire
    # range, and their price.
    # This could be used to let the user select which of several
    # room options they desire.
    def find_continious_open_room(nights)
      if nights.class == Date
        nights = [nights]
      end
      array_of_rooms = unreserved_and_unblocked(nights)
      free_for_range = {}
      array_of_rooms[0].each do |room, cost|
        free = true
        array_of_rooms.each do |free_rooms|
          free = free && (free_rooms[room] != nil)
        end
        if free == true
          free_for_range[room] = cost
        end
      end
      return free_for_range
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
      @all_reservations.each do |reservation|
        if reservation.reservation_id == reservation_id
          return reservation
        end
      end
      return nil
    end

    #can be used for "As an administrator, I can access the list of
    # reservations for a specific date"
    def find_reservations_by_date(date)
      reservations_on_date = []
      @all_reservations.each do |reservation|
        if reservation.nights_booked.include?(date)
          reservations_on_date << reservation
        end
      end
      return reservations_on_date
    end

    ####Methods to find blocks ####
    def find_by_block_id(block_id)
      @all_blocks.each do |block|
        if block.block_id == block_id
          return block
        end
      end
      return nil
    end

    def find_blocks_by_date(date)
      blocks_on_date = []
      @all_blocks.each do |block|
        if block.nights_held.include?(date)
          blocks_on_date << block
        end
      end
      return blocks_on_date
    end
  end
end
