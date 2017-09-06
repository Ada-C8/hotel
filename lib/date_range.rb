require 'pry'
require 'date'

module Hotel
  class DateRange
    attr_reader :check_in, :check_out, :nights, :nights_arr

    def initialize(check_in, check_out)
    @check_in = check_in
    @check_out = check_out
    @nights = (@check_out - @check_in).to_i
    @nights_arr = []
    end

    #in start date [5], end date[6]
    #out array of nights [5,6]

    def valid_date?
      if @check_in > @check_out
        raise InvalidDateRangeError.new("Invalid Date Range: Check-out #{@check_out} is before Check-in #{@check_in}")
      end
    end
    #check that is vaild input, that the dates are appropriate range and are of type dates.

    #use for booking a reservation and for checking reservations
  end
end
