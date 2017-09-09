require 'date'
require 'pry'
module Hotel
  class DateRange
    # GOAL OF CLASS: to return an array of each of the days for the date_range given
    attr_reader :checkin, :checkout, :total_nights, :night_array

    def initialize(checkin, checkout)
      @checkin = checkin
      @checkout = checkout
      @total_nights = (@checkout - @checkin).to_i
      @night_array = []
      make_nights_array
    end

    def check_valid
      if @checkin < @checkout
        return true
      else raise StandardError.new "invalid dates. Checkout date: #{@checkout} must be AFTER the Checkin date: #{@checkin}"
      end
    end

    def make_nights_array
      if check_valid
        counter = 0
        @total_nights.times do
          @night_array << (@checkin + counter)
          counter += 1
        end
      end
      return @night_array
    end

    def include?(date)
      return @night_array.include?(date)
    end
  end
end
