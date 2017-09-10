require 'pry'
require 'date'
require_relative 'booking'

module Hotel
  class Block < Booking
    attr_reader :id, :rooms, :date_range, :nights, :total_cost, :block_info, :block_name, :discount, :reserved_rooms

    def initialize(id, rooms, date_range, block_info)
      super(id, rooms, date_range)
      @block_info = block_info
      @reserved_rooms = []
    end

    def rooms_available_block
      # count = @rooms.length - @reserved_rooms.length
      return @rooms
    end

    def book_room_in_block(num_rooms)
      if num_rooms > 5 || num_rooms > @rooms.length

      # block_info = [@block_name, @discount_room_price]
      rooms_available_block.length
        raise InvalidRoomQuantity.new("Unfortunately the hotel does not have enough rooms left in the block to handle your request of #{num_rooms} rooms.")
      end
      #
      # rooms_arr = []
      # num_rooms.times do
      #   copy = self.rooms.shift(1)
      #   copy1 = copy
      #   self.reserved_rooms << copy1
      #   rooms_arr << copy1
      # end
      #
      # booking = Hotel::Booking.new(0,rooms_arr, @date_range, [@block_name, @discount_room_price])
      #
      # return booking
    end
  end
end
