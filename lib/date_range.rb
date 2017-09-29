require 'date'

module Hotel
  class DateRange
    attr_reader :check_in, :check_out

    def initialize(checkin, checkout)
      unless checkout > checkin
        raise InvalidDateRange.new("Invalid dates #{checkin} to #{checkout}") # I took this from the example--I wouldn't have thought to put this here and it is such a good idea
      end

      @checkin = checkin
      @checkout = checkout
    end # end initialize

    def length_of_stay
      return @check_out - @check_in
    end # end length_of_stay

    def overlap?(other)
      @checkout < other.checkin || @checkin > other.checkout
    end # end overlap?
  
  end # end of class
end # end of module
