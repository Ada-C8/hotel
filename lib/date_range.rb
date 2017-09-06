require 'pry'
require 'date'

module Hotel
  class DateRange

    def initialize(check_in, check_out)
    @check_in = check_in
    @check_out = check_out
    @nights = (@check_out - @check_in).to_i
    @nights_arr = []

    end
    #in start date [5], end date[6]
    #out array of nights [5,6]


    #check that is vaild input, that the dates are appropriate range and are of type dates.

    #use for booking a reservation and for checking reservations
  end
end
