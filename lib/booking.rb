require 'pry'
require 'date'

module Hotel
  class Booking
    attr_reader :id, :rooms, :date_range, :nights, :total_cost, :block_info

    def initialize(id, rooms, date_range, block_info = nil) #blockname and price? or whole block?
      @id = id
      @block_info = block_info
      @rooms = rooms
      @date_range = date_range
      @nights = date_range.nights
      @total_cost = (@nights * rooms.inject(0){|sum,room| sum + room.cost})
      # @total_cost = ''
      total_cost
    end
    #to book a roomin a block we would need to have total_cost update with the discounted range_of_dates
    # def total_cost
    #   if @block_info == nil
    #     @total_cost = (@nights * rooms.inject(0){|sum,room| sum + room.cost})
    #   else
    #     @total_cost = (@nights * rooms.inject(0){|sum,room| sum + room.cost})
    #   end
    # end
  end
end
