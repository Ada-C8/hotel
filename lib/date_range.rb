require 'pry'
require 'date'

module Hotel

  class DateRange

    attr_reader :check_in, :check_out, :date_range

    def initialize
    end

    #Your code should raise an error when an invalid date range is provided
    def self.check_in(date)
      @check_in = Date.parse(date)
      # if Date.valid_date?(@check_in.year, @check_in.mon, @check_in.wday)
        return @check_in
      # else
      #   raise Arguement Error
      #end
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
    #
    # def self.create_range
    #   date_range = []
    #   @check_in.upto(@check_out).each do |date|
    #     date_range << date
    #   end
    #   return date_range
    # end

  end #date class
end #module
#binding.pry
#include?
#overlap?
#.each
