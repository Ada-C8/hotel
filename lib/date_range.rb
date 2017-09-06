
require 'date'
module My_Hotel
  class Date_Range

    attr_reader :arrive, :leave, :nights

    def initialize(arrive, leave)
      @arrive = Date.civil(arrive[0], arrive[1], arrive[2])
      @leave = Date.civil(leave[0], leave[1], leave[2])
      @nights = (@arrive..(@leave.prev_day))
    end



    # def valid_dates?
    # end

    #is the start_date before the end_date?
    #accepts date as a string [year, month, day]
    def overlap?(input_date)
      input_date = Date.civil(input_date[0], input_date[1], input_date[2])
      @nights.include?(input_date)
    end



  end
end


#h = My_Hotel::Date_Range.new([2017,1,2], [2017,1,5])
