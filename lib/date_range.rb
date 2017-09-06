
require 'date'
module My_Hotel
  class Date_Range

    attr_reader :arrive, :leave, :nights

    def initialize(arrive, leave)
      @arrive = arrive
      @leave = leave
      @nights = (@arrive..(@leave.prev_day))
    end



    # def valid_dates?
    # end

    #is the start_date before the end_date?
    #accepts date as a string [year, month, day]
    def overlap?(input_date)
      @nights.include?(input_date)
    end



  end
end


# arrive = Date.civil(2017, 12, 20)
# leave = Date.civil(2017, 12, 23)
# puts leave
# puts leave.prev_day

# holiday = My_Hotel::Date_Range.new(arrive, leave)
# puts holiday
