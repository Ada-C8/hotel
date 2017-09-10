require 'date'

require_relative 'daterange'

module Hotel
  class Reservation
    COST_PER_NIGHT = 200

    attr_reader :reservation_array, :total_cost, :room_num, :date_range_array

    def initialize(room_num, check_in, check_out)

      # @reservation_array = []
      @total_cost = 0
      @room_num = room_num
      @date_range_array = DateRange.new(check_in, check_out).date_range_array
    end



    def total_cost
      (@date_range_array.length - 1) * COST_PER_NIGHT
    end



  end # end class
end #end module
