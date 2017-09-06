require 'date'

module BookingSystem

  class DateRange

    attr_reader :check_in, :check_out

    def initialize(check_in, check_out)
      @check_in = check_in
      @check_out = check_out

      if check_in.class != Date || check_out.class != Date || @check_in > @check_out
        raise ArgumentError.new("Invalid date range")
      end
    end #end of initialize


    def dates_within_range

    end #end of method

    # def valid_dates?
    #   if @check_in < @check_out
    #     return true
    #   end
    #   raise ArgumentError.new("Invalid date range")
    # end #end of method


  end #end of class

end #end of module
