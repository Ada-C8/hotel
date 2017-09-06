require 'date'
require 'awesome_print'

module Hotel
  class DateRange
    attr_reader :start_date, :end_date, :number_of_nights
    def initialize(start_date, end_date)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      @number_of_nights = (@end_date - @start_date).to_i
    end # end of initialize

    def return_date_range
      date_range = "#{@start_date} to #{@end_date}"
      # Hotel::HotelClass.reservations << date_range
      return date_range
    end # end of return_date_range
  end # end of DateRange Clas
end # end of Module

test = Hotel::DateRange.new("2017-9-12", "2017-9-15")
test.return_date_range
