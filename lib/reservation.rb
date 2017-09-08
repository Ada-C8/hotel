module Administration
  class Reservation

    attr_accessor :check_in, :check_out

    def initialize(check_in, check_out)
      @check_in = check_in
      @check_out = check_out
    end

    def total_nights
      total_nights = (@check_out - @check_in)
      return total_nights.ceil
    end


  end #reservation
end #module
