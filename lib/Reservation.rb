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



    # def reservation_id
    #   Hotel::Admin.reservations.length + 1
    # end

    

    def total_cost
      (@date_range_array.length - 1) * COST_PER_NIGHT
    end

    # def self.find_all(check_in, check_out)
    #
    #   # take array of reservations
    #   # interate over each to find the reservations for reserved status by date
    #   @reservation_array.each do |reservation|
    #     list_reservations =
    #   end
    #   return list_reservations
    # end
    #


  end # end class
end #end module
