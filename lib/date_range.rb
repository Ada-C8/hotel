require 'pry'
require 'date'

module Hotel

  class DateRange

    attr_reader :check_in, :check_out, :date_range

    def initialize
    end

    def self.check_dates(first, last)
      if Date.parse(first) > Date.parse(last)
        raise ArgumentError, "Check Out Date is earlier than Check in Date"
      end
    end

    def self.check_in(date)
      @check_in = Date.parse(date)
        return @check_in
    end

    def self.check_out(date)
      @check_out = Date.parse(date)
      return @check_out
    end

    def self.create_range(first, last)
      date_range = []
      first.upto(last).each do |date|
        date_range << date
      end
      return date_range
    end

  end #date class
end #module
