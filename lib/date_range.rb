require 'date'

module Hotel
  class DateRange
    attr_reader :check_in, :check_out

    def initialize(check_in, check_out)
      @check_in = Date.new(check_in)
      @check_out = check_out
    end # end initialize
  end # end of class
end # end of module
