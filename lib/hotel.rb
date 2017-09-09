require_relative 'date_range'

module Booking
  class Hotel
    attr_reader :list_of_rooms, :list_of_reservations

    def initialize
      @list_of_rooms = [*1..20]
      @list_of_reservations = []
      @list_of_blocks = []
    end


    #I can reserve an available room for a given date range
    def make_reservation(checkin, checkout, room_number)
      date_range = DateRange.new(checkin, checkout)
      all_available_rooms = available_rooms(date_range)
      if all_available_rooms.include?(room_number)
        reserve =  Reservation.new(checkin, checkout, room_number)
        list_of_reservations << reserve
      end
      return reserve
    end


    #returns list of reservations for specific date
    def list_of_reservations_for_a_date(date)
      found_reservations = []
      @list_of_reservations.each do |reserve|
        if reserve.date_range.is_included?(date)
          found_reservations << reserve
        end
      end
      return found_reservations
    end

    # Gives list of available rooms for a given date
    def available_rooms(date_range)
      available_rooms = Array.new(21, true) # Setting all rooms to available
      @list_of_reservations.each do |r|
        if (date_range.overlaps?(r.date_range)) # if date_ranges intersects
          available_rooms[r.room_number] = false # the room at that index becomes unavailable
        end
      end
      # returns an array of true (available) rooms
      result = []
      available_rooms.each_with_index do | is_available, room_number|
        if room_number != 0 && is_available && !reserved_by_any_block(date_range, room_number)
          result << room_number
        end
      end
      return result
    end

    #checks if room number is inside of any block
    def reserved_by_any_block?(date_range, room_number)
      @list_of_blocks.each do |block|
        if (date_range.overlaps?(block.date_range) && block.has_room_number?(room_number))
          return true
        end
      end
      return false
    end

    # Creates block from available rooms in a given date range
    def create_block(block_name, date_range, rooms, discounted_room_rate)
      # date_range = DateRange.new(checkin, checkout)
      available_room_list = available_rooms(date_range)
      rooms.each do |room|
        if !available_room_list.include?(room)
          raise ArgumentError.new("room not available")
        end
      end
      @list_of_blocks << Block.new(block_name, date_range, rooms, discounted_room_rate)
    end

    # returns list of rooms available in a given block
    def available_rooms_in_a_block(block_name)
      return find_block(block_name).available_rooms
    end

    def find_block(block_name)
      @list_of_blocks.each do |block|
        if block.block_name == block_name
          return block
        end
      end
      raise ArgumentError.new("Block doesn't exist")
    end

    #  reserves a room from block
    def reserve_room_from_block(room_number, block_name)
      block = find_block(block_name)
      if block.available_rooms.include?(room_number)
        block.already_reserved_rooms  << room_number
        block.available_rooms.delete(room_number)
      else
        raise ArgumentError.new("The room is not available in this block")
      end
    end
    
  end
end
