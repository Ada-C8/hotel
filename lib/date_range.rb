require 'Date'
module HotelClass
  class DateRange
    def initialize(start_date, end_date)
      @start_date = Date.new(start_date)
      @end_date = Date.new(end_date)
      @number_of_nights = (@end_date - @start_date).to_i
    end
  end
end
