require 'date'

module Hotel
  class DateRange
    attr_reader :check_in, :check_out

    def initialize(check_in, check_out)
      @check_in = check_in
      @check_out = check_out
    end # end initialize

    def find_range
      @check_out - @check_in
    end # end date_range
  end # end of class
end # end of module
