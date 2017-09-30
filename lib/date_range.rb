
require 'date'

module Booking
  class DateRange
    attr_reader :start_date, :end_date

    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date
      if !@end_date.is_a?(Date) || !@start_date.is_a?(Date)
        raise ArgumentError.new("Both start_date and end_date must be valid Date objects")
      elsif @end_date <= @start_date
        raise ArgumentError.new("Entered invalid date_range")
      end
    end

    def is_included?(date)
      if date >= @start_date && date < @end_date
        return true
      else
        return false
      end
    end

    def number_of_nights
      return (@end_date - @start_date)
    end


    def overlaps?(other_date_range)
      self.is_included?(other_date_range.start_date) || other_date_range.is_included?(self.start_date)
    end
  end
end
