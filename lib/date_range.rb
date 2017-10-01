require 'spec_helper'

module Hotel
  class DateRange
    class InvalidDateRange < StandardError ; end
    attr_reader :check_in, :check_out

    def initialize(check_in, check_out)
      unless check_out > check_in
        raise InvalidDateRange.new("Invalid dates #{check_in} to #{check_out}") # I took this from the example--I wouldn't have thought to put this here and it is such a good idea
      end

      @check_in = check_in
      @check_out = check_out
    end # end initialize

    def number_of_nights
      return @check_out - @check_in
    end # end number_of_nights

    def overlap?(other)
      @check_out < other.check_in || @check_in > other.check_out
    end # end overlap?

  end # end of class
end # end of module
