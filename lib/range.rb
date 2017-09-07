require 'date'
require 'range_operators'

module Property

  class Range
    attr_reader :check_in, :check_out

    def initialize(check_in, check_out)

      unless @check_in < @check_out
        raise ArgumentError.new "Invalid date range" #return true ?
      end
      @check_in = check_in
      @check_out = check_out
    end

    # def valid?
    #   unless @check_in < @check_out
    #     raise ArgumentError.new "Invalid date range" #return true ?
    #   end
    #   return true
    # end

    def overlap?(date)
      if @check_in < date.check_in && @check_out > date.check_out ||
        @check_in < date.check_in && @check_out < date.check_out
        return false
      else
        return true
      end
    end

    def num_nights
      return @check_out - @check_in
    end

  end
end
