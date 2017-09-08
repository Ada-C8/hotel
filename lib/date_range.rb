require 'date'
require_relative 'invalid_date'

module BookingSystem

  class DateRange

    attr_reader :check_in, :check_out

    def initialize(check_in, check_out)
      @check_in = check_in
      @check_out = check_out

      if @check_in.class != Date || @check_out.class != Date || @check_in > @check_out || @check_in < Date.today
        raise InvalidDate.new("Invalid date or date range")
      end
    end #end of initialize

    def dates_within_range
      dates = (@check_in .. @check_out - 1).map { |date| date }
      return dates
    end #end of method

  end #end of class

end #end of module
