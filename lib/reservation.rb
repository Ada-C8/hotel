require_relative 'date_range'#take note this needs to be included at the top
require 'pry'
require 'Date'

module Hotel

  class Reservation

    attr_reader :check_in, :check_out, :date_range, :room_num, :cost, :reservation_array

    def initialize(check_in, check_out, room_num, cost = 200)
      @reservation_array = []

      @date_range = DateRange.new(check_in, check_out)
      @reservation_array << @date_range

      @room_num = room_num
      @reservation_array << @room_num

      @cost = cost
      @reservation_array << @cost



    end #initialize

    def total_cost
      num_nights = (@date_range.check_out - @date_range.check_in).to_i
      return num_nights * @cost
    end

  end #reservation


end #module

# hotel = Hotel::Reservation.new('sept 9 2016', 'sept 9 2017', 18)
# puts hotel.date_range.check_out
