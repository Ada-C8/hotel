require 'date'

require_relative 'daterange'

module Hotel
  class Block
    COST_PER_NIGHT = 200.00

    attr_reader  :room_num_array, :block_date_range_array, :discount_percent, :block_id, :reservations_array

    def initialize(room_num_array, check_in, check_out, block_id, discount_percent: 0)


      @room_num_array = room_num_array
      @block_date_range_array = DateRange.new(check_in, check_out).date_range_array
      # what to automate block_id and was stumped on implementation. So I opted for manuel entry
      @block_id = block_id
      @discount_percent = discount_percent


      @reservations_array = []
    end



    def total_cost
      full_price = (@block_date_range_array.length - 1) * COST_PER_NIGHT
      discount = full_price * (discount_percent/100.0)
      return total_cost = full_price - discount
    end


    def make_reservation(room_num, check_in, check_out, discount_percent: 0)
        reservations_array << Hotel::Reservation.new(room_num, check_in, check_out, discount_percent: 0)
    end



  end # end class
end #end module
