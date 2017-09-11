
require 'date'
require 'date_range'
require_relative 'BookingSystem_Errors'

module BookingSystem
  class Block

    attr_reader :block_id, :date_range, :rooms_array, :discount_room_rate

    def initialize(block_id, date_range, rooms_array, discount_room_rate)
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

  end#of_Block_class
end#of_module_BookingSystem
