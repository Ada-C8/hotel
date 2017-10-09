require 'date'
require 'pry'
module Hotel
  class DateRange
    # GOAL OF CLASS: to return an array of each of the days for the date_range given
    attr_reader :checkin, :checkout, :total_nights, :nights

    def initialize(checkin, checkout)
      @checkin = checkin
      @checkout = checkout
      @total_nights = (@checkout - @checkin).to_i
      @nights = []
      make_nights
    end

    def check_valid
      if @checkin < @checkout
        return true
      else raise DateRangeError.new "invalid dates. Checkout date: #{@checkout} must be AFTER the Checkin date: #{@checkin}"
      end
    end

    def make_nights
      if check_valid
        counter = 0
        @total_nights.times do
          @nights << (@checkin + counter)
          counter += 1
        end
      end
      return @nights
    end

    def include?(date)
      return @nights.include?(date)
    end
  end
end
