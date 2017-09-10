require 'pry'
require 'date'

module Hotel
  class Booking
    attr_reader :id, :rooms, :date_range, :nights, :total_cost, :block_info

    def initialize(id, rooms, date_range, block_info: nil) #blockname and price? or whole block?
      @id = id
      @block_info = block_info
      @rooms = rooms
      @date_range = date_range
      @nights = date_range.nights
      @total_cost = (@nights * rooms.inject(0){|sum,room| sum + room.cost})
      # @total_cost = 0
      # total_cost[@block_name
    end
    # to book a roomin a block we would need to have total_cost update with the discounted range_of_dates
    # def calc_total_cost
    #   if @block_info.length > 0
    #     total = @rooms.length * @nights * @block_info[1]
    #     @total_cost = total
    #   else
    #     @total_cost = (@nights * rooms.inject(0){|sum,room| sum + room.cost})
    #   end
    # end
  end
end
