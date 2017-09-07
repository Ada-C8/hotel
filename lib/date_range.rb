require 'pry'
require 'date'

module Hotel

  class DateRange

    attr_reader :check_in, :check_out, :date_range

    def initialize
      # @check_in = Date.new
      # @check_out = Date.new
      #@date_range = []
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
    def self.create_range
      date_range = []
      @check_in.upto(@check_out).each do |date|
        date_range << date
      end
      return date_range
    end

  end #date class
end #module
#binding.pry
#include?
#overlap?
#.each
