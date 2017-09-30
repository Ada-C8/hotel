require "date"
require_relative "room"

require "pry"

module Hotel
  class DateRange
    DATE = /^[0-9]{1,2}-[0-9]{1,2}-[0-9]{4}$/
    attr_reader :check_in, :check_out

    def initialize(check_in, check_out)
      @check_in = Date.strptime(check_in, "%m-%d-%Y") #keep this method for date
      @check_out = Date.strptime(check_out, "%m-%d-%Y") #month-day-fullyear
      #test dates in ascending order
      if @check_out < @check_in
        raise ArgumentError.new("Dates are in an invalid range/wrong order?")
      end
      #test regex, test dates in past
      arr = []
      arr << check_in
      arr << check_out
      arr.each do |date_entered|
        if DATE.match(date_entered)
          if Date.strptime(date_entered, "%m-%d-%Y") < Date.today
            raise ArgumentError.new("These are dates in the past")
          end
        else
          raise ArgumentError.new("Date does not match XX-XX-XXX format")
        end
      end
    end

    def date_range
      array = []
      (check_in..check_out).each do |d|
        array << "#{d.month}-#{d.day}-#{d.year}"
      end
      return array
    end
  end
end
