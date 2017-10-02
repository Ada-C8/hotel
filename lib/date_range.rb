require 'date'

module Hotel
  class InvalidDateRangeError < StandardError
  end

  class DateRange
    attr_reader :start_date, :end_date, :number_of_nights

    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date
      # check_valid
      @number_of_nights = (end_date - start_date).to_i
      check_valid

    end

    def check_valid
      raise InvalidDateRangeError.new("Invalid Date Range.") if @number_of_nights <= 0
    end

    def nights_arr
      nights_arr = []
      @number_of_nights.times do |i|
        nights_arr << (@start_date + i)
      end
      return nights_arr
    end

    def include?(check_date)
      nights_arr.each do |date|
        return true if date == check_date
      end
      return false
    end

    def overlap?(check_date_range)
      if @end_date > check_date_range.start_date || @start_date <= check_date_range.end_date
        return true
      else
        return false
      end
    end

  end
end
