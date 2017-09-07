require 'pry'
require 'date'

module Hotel

  class DateRange

    attr_reader :check_in, :check_out, :date_range

    def initialize
      @check_in = Date.new
      @check_out = Date.new
      @date_range = []
    end

=begin
From hotel class, enter two dates (as strings)
call DateRange and use those strings to create a Date objects for check in and check out and then an array of dates
=end
    #Your code should raise an error when an invalid date range is provided
    def self.check_in(date)
      @check_in = Date.parse(date)
      return @check_in
    end

    def self.check_out(date)
      @check_out = Date.parse(date)
      return @check_out
    end
    #
    # def create_range
    #   @check_in.upto(@check_out).each do |date|
    #     @date_range << date
    #   end
    #   return @date_range
    # end
    #
    # def self.test_range(check_in, check_out)
    #   (Date.new(check_in)..Date.new(check_out)).each do |date|
    #     return "Date: #{date}"
    #   end
    # end

    # def self.test_range(yr,mo,day,yr2,mo2,day2)
    #   check_in = Date.new(yr,mo,day)
    #   check_out = Date.new(yr2,mo2,day2)
    #   check_in.upto(check_out).each do |date|
    #     puts "Date: #{date}"
    #   end
    #
    # end

    # Date.new(2012,01,01).upton(Date.new(2012,01,30) do |date| )
    #   do stuff
    #   end


  end #date class
end #module
#binding.pry
#include?
#overlap?
#.each
