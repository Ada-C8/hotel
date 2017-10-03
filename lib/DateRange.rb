

module Hotel

  class DateRange

    attr_reader :check_in, :check_out, :date_range_array

    def initialize(check_in, check_out)
      raise ArgumentError.new("Please enter a Check Out date that comes after Check In date.") if check_in >= check_out

      @check_in = check_in
      @check_out = check_out
      @date_range_array = (check_in..check_out).to_a
    end


    def include(date)
      if date >= @check_in && date <= @check_out
        return true
      end
    end

    def overlap?(other)
      return !(other.check_out <= @check_in || other.check_in >= @check_out)
    end

    def total_num_of_nights
      return check_out - check_in
    end




  end
end
