
require 'date'
module My_Hotel
  class Date_Range

    attr_reader :nights

    def initialize(first_night, last_night)
      @nights = (first_night..last_night)
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
#
#
# arrive = Date.civil(2017, 12, 20)
# leave = Date.civil(2017, 12, 23)
# puts leave
# puts leave.prev_day
#
# holiday = My_Hotel::Date_Range.new(arrive, leave)
# puts holiday.nights.class
# holiday.nights.each do |night|
#   puts "x =1"
# end
