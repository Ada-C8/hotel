require 'date'
module Hotel
  class DateRange
    attr_reader :start_date, :end_date, :number_of_nights
    def initialize(start_date, end_date)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      @number_of_nights = (@end_date - @start_date).to_i
    end


  end
end
