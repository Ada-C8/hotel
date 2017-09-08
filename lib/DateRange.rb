

module Hotel

  class DateRange

    attr_reader :check_in, :check_out, :date_range_array

    def initialize(check_in, check_out)
      raise ArgumentError.new("Please enter a Check Out date that comes after Check In date.") if check_in > check_out

      @check_in = check_in
      @check_out = check_out
      @date_range_array = (check_in...check_out).to_a
    end


    # def include?(date)
    #   reserevation.include?(Date.new(2017,2,2))
    # end





  end
end
