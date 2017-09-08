require 'pry'
require 'date'

module Hotel
  class DateRange
    attr_reader :check_in, :check_out, :nights, :nights_arr

    def initialize(check_in, check_out)
    @check_in = check_in
    @check_out = check_out
    # @nights = (@check_out - @check_in).to_i
    @nights = ''
    @nights_arr = []
    make_nights_arr
    end
    def valid_input?
      if @check_in.class != Date || @check_out.class != Date
        raise ArgumentError.new("User input Check-in: #{@check_in} and Check-out: #{@check_out} are not valid inputs, must be a Date Object.")
      end
    end

    def valid_date?
      valid_input?
      if @check_in > @check_out
        raise InvalidDateRangeError.new("Invalid Date Range: Check-out #{@check_out} is before Check-in #{@check_in}")
      end
    end #end valid_date? method

    def make_nights_arr
      valid_date?
      @nights = (@check_out - @check_in).to_i
      counter = 0
      @nights.times do
        @nights_arr << (@check_in + counter)
        counter += 1
      end
      # return @nights_arr
    end #end make_nights_arr method
  end #end DateRange class
end #end Hotel module
