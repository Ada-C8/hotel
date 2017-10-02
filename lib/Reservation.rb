require 'date'

require_relative 'daterange'

module Hotel
  class Reservation
    COST_PER_NIGHT = 200.00

    attr_reader :total_cost, :room_num, :date_range_array

    def initialize(room_num, check_in, check_out, discount_percent: 0)

      # @reservation_array = []
      @total_cost = 0
      @room_num = room_num
      @date_range_array = DateRange.new(check_in, check_out).date_range_array
    end

    # def total_cost
    #   full_price = (@block_date_range_array.length - 1) * COST_PER_NIGHT
    #   discount = full_price * (discount_percent/100.0)
    #   return total_cost = full_price - discount
    # end

    def total_cost
      full_price = (@date_range_array.length - 1) * COST_PER_NIGHT
      discount = full_price * (discount_percent/100.0)
      return total_cost = full_price - discount
    end



  end # end class
end #end module
