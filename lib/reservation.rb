module Administration
  class Reservation

    RATE = 200

    attr_accessor :check_in, :check_out

    def initialize(check_in, check_out)
      @check_in = check_in
      @check_out = check_out
    end

    def total_nights
      total_nights = (@check_out - @check_in)
      return total_nights.ceil
    end

    def total_cost
      total_cost = (total_nights * RATE)
      return total_cost
    end

  end #reservation
end #module
