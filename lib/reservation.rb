module Administration
  class Reservation

    attr_accessor :check_in, :check_out

    def initialize(check_in, check_out)
      @check_in = check_in
      @check_out = check_out
    end


  end #reservation
end #module
