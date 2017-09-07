require 'pry'

module Hotel

  class DateRange

    attr_reader :check_in, :check_out

    def initialize(check_in, check_out)
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)

      if @check_in > @check_out
        raise ArgumentError.new("Invalid date range")
      end
    end



  end #class

end #hotel
