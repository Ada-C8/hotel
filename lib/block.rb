require 'pry'
require 'date'
require_relative 'booking'

module Hotel
  class Block < Booking
    def initialize(id, rooms, date_range, block_info, block_name, discount)
      super(rooms, date_range, block_info)
      @discount_room_price = discount
      @block_name = id
    end
  end
end
