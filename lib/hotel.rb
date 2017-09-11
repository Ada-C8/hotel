#Hotel.rb
require 'awesome_print'
require 'date'
require 'pry'

module Hotel_Chain
  class MyHotel

    attr_reader :array_of_rooms, :reservations_array, :blocks_array

    def initialize(no_of_rooms = 20)
      @array_of_rooms = Array.new(no_of_rooms)
      no_of_rooms.times do |room|
        @array_of_rooms[room] = Room.new(room+1)
      @reservations_array = []
      @blocks_array = [] #an array of block objects
      end
    end

    def list_rooms
      list_array = []
      i = 0
      @array_of_rooms.each do |object|
          list_array << "#{i+1}. Room #{object.room_id} - $#{object.rate}/night"
          i += 1
      end
      return list_array
    end

    def find_reservations_by_date(date)
      reservations_on_date = []
      @reservations_array.each do |reservation|
        if (reservation.check_in_date...reservation.check_out_date).cover?(Date.strptime(date, "%m/%d/%Y"))
          reservations_on_date << reservation
        end
      end
      return reservations_on_date
    end

    def print_reservations_by_date(date)
      array = []
      reservations_on_date = self.find_reservations_by_date(date)
      reservations_on_date.each do |reservation|
        array  << "Room #{reservation.room.room_id} is reserved from #{reservation.check_in_date} to #{reservation.check_out_date}"
      end
      ap array
      return array
    end

    def store_reservation(check_in_date, check_out_date)
      available_rooms = []
      #ap "STORE_RESERVATION START: reservations_array: #{reservations_array}"
      if @reservations_array.length == 0 #i.e. there are no reservations at all
        new_reservation = Hotel_Chain::Reservation.new(check_in_date, check_out_date)
        new_reservation.room = @array_of_rooms[0]
        @reservations_array << new_reservation
        return new_reservation
      elsif @reservations_array.length > 0
        available_rooms = find_rooms_available(check_in_date, check_out_date)
        if available_rooms.length == 0
          raise ReservationNotAvailableError
        else
          new_reservation = Hotel_Chain::Reservation.new(check_in_date, check_out_date)
          new_reservation.room = available_rooms[0]
          @reservations_array << new_reservation
          return new_reservation
        end
      end
    end

    def find_rooms_available(check_in_date, check_out_date)
      available_rooms = []
      unavailable_rooms = []

      check_in = Date.strptime(check_in_date, "%m/%d/%Y")
      check_out = Date.strptime(check_out_date, "%m/%d/%Y")

      @array_of_rooms.each do |room|
        @reservations_array.each do |reservation|
          # checks for unavailable rooms
          if room.room_id == reservation.room.room_id && reservation.block_reserved == true
            unavailable_rooms << room
          elsif room.room_id == reservation.room.room_id && reservation.check_in_date < check_in && (reservation.check_out_date < check_out && reservation.check_out_date > check_in)
            unavailable_rooms << room
          elsif room.room_id == reservation.room.room_id && (reservation.check_in_date < check_out && reservation.check_in_date > check_in) && reservation.check_out_date > check_out
            unavailable_rooms << room
          elsif room.room_id == reservation.room.room_id && (reservation.check_in_date > check_in && reservation.check_in_date < check_out) && (reservation.check_out_date < check_out && reservation.check_out_date > check_in)
            unavailable_rooms << room
          elsif room.room_id == reservation.room.room_id && reservation.check_in_date < check_in && reservation.check_out_date > check_out
            unavailable_rooms << room
          elsif room.room_id == reservation.room.room_id && reservation.check_in_date == check_in
            unavailable_rooms << room
          elsif room.room_id == reservation.room.room_id && (reservation.check_in_date > check_in && reservation.check_in_date < check_out) && reservation.check_out_date == check_out
            unavailable_rooms << room
          end
        end
      end
      final_available_rooms = @array_of_rooms - unavailable_rooms
      return final_available_rooms
    end


    def reserve_block(party_name, check_in, check_out, no_of_rooms, room_rate)
      if no_of_rooms > 5
        raise ExceededRoomLimitForBlocksError
      end

      local_reservation_array = []
      available_rooms = find_rooms_available(check_in, check_out)

      if available_rooms.length < no_of_rooms
        raise ArgumentError.new("There are not enough rooms available to reserve that block")
      else
        no_of_rooms.times do |room|
          new_reservation = store_reservation(check_in, check_out)
          new_reservation.room.rate = room_rate
          new_reservation.block_reserved = true
          new_reservation.status = "unassigned"
          ap "New reservation: #{new_reservation}"
          @reservations_array << new_reservation
          local_reservation_array << new_reservation
        end
      end

      #I want the block object to have these attributes for ease of reference.
      new_block = Block.new(party_name, check_in, check_out, room_rate, local_reservation_array)
      @blocks_array << new_block
      return new_block
    end

    def find_unassigned_block_reservations(party_name)
      #if the block has the desired party name, then return that block
      this_block = nil
      @blocks_array.each do |block|
        if block.party_name == party_name
          this_block = block
        end
      end

      if this_block == nil
        raise NoPartyByThatNameError
      end

      unassigned_reservations = []
      this_block.reservations_array.each do |reservation|
        if reservation.status == "unassigned"
          unassigned_reservations << reservation
        end
      end

      if unassigned_reservations.empty?
        raise AllBlockRoomsAssignedError
      end

      return unassigned_reservations
    end

    def assign_block_reservation(party_name)
      unassigned_reservations = find_unassigned_block_reservations(party_name)
      unassigned_reservations[0].status = "assigned"
      return unassigned_reservations[0]
    end

    #this can be used to find if there is a block reservation party name in the system
    def match_block_partyname(party_name)
      reserved_under = []
      @blocks_array.each do |block|
        if (block.party_name.downcase).match(party_name.downcase)
          reserved_under << block.party_name
          ap block.party_name
        end
      end
      return reserved_under
    end

  end #end of class
end #end of module
