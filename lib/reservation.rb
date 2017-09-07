require_relative 'date_range'#take note this needs to be included at the top
require 'pry'

module Hotel

  class Reservation

    attr_reader :check_in, :check_out, :date_range, :room_num, :cost, :reservation_array, :num_nights

    def initialize(check_in, check_out, room_num, cost = 200)
      @reservation_array = []

      @date_range = DateRange.new(check_in, check_out)
      @reservation_array << @date_range

      @room_num = room_num
      @reservation_array << @room_num

      @cost = cost
      @reservation_array << @cost

      # @reservation_collection << @reservation_array
    end #initialize

    def total_cost
      num_nights = (@date_range.check_out - @date_range.check_in).to_i
      return num_nights * @cost
    end

  end #reservation


end #module
