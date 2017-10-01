
require 'date'
require 'date_range'
require_relative 'BookingSystem_Errors'

module BookingSystem
  class Block

    attr_reader :block_id, :date_range, :rooms_array, :discount_room_rate

    def initialize(block_id, date_range, rooms_array, discount_room_rate, reservation_list)

      #Hotel Revisted Changes: Checks the reservation for any date range that would overlap with the block_id's date_range and throws an error if it detects an overlap
      raise UnavailableRoomError.new("Room is unavailable") if reservation_list.any? {|reservation|
        rooms_array.include?(reservation.room_id) &&
        #overlaps? same as: !(reservation.start_date >= date_range.last || reservation.end_date <= date_range.first)
        reservation.date_range.overlaps?(date_range) && date_range.first < reservation.end_date
      }

      raise ArgumentError.new("Block ID must be a string") if !block_id.is_a? String
      @block_id = block_id

      raise InvalidDateRangeError.new("Date range must be a DateRange object") if !date_range.is_a? DateRange
      @date_range = date_range

      raise ArgumentError.new("Rooms collection must be an Array") if !rooms_array.is_a? Array
      raise BlockError.new("Rooms array cannot have more than 5 rooms") if rooms_array.length > 5
      @rooms_array = rooms_array

      raise ArgumentError.new("Room rate discount must be a float") if !discount_room_rate.is_a? Float
      @discount_room_rate = discount_room_rate
    end

    def list_room_ids
      room_ids = @rooms_array.map { |room| room.id }
      return room_ids
    end

  end#of_Block_class
end#of_module_BookingSystem
