require 'pry'
require 'date'
require_relative 'booking'

module Hotel
  class Block < Booking
    attr_reader :id, :rooms, :date_range, :nights, :total_cost, :block_info, :block_name, :discount, :reserved_rooms

    def initialize(id, rooms, date_range, block_info)
      super(id, rooms, date_range)
      @block_info = block_info
    end

    def rooms_available_block
      rooms_available = []
      @rooms.each do |room|
        if room.booked == false || room.booked == nil
          rooms_available << room
        end
      end
      return rooms_available
    end
  end
end
