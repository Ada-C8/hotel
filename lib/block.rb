require 'pry'
require 'date'
require_relative 'booking'

module Hotel
  class Block < Booking
    attr_reader :id, :rooms, :date_range, :nights, :total_cost, :block_info, :block_name, :discount

    def initialize(id, rooms, date_range, block_info = nil, block_name, discount)
      super(id, rooms, date_range, block_info)
      @discount_room_price = discount
      @block_name = block_name
    end
  end
end
