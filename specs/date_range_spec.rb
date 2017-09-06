# Testing for date_range
# Edited 9/5/17
require_relative 'spec_helper'

describe "Date Range" do

  before do
    checkin_date = Date.new(2001,2,3)
    checkout_date = Date.new(2001,2,14)
    @date = Hotel::DateRange.new(checkin_date, checkout_date)
  end

  describe "initialize method" do
    it "takes checkin and checkout dates" do
      @date.must_be_instance_of Hotel::DateRange
    end
  end

  describe "date include" do
    it "checks if a date is included in the date range" do

      @date.date_include?(Date.new(2001,2,5)).must_equal true
    end

    it "raises an error for an invalid date" do
      proc{@date.date_include?(Date.new(2007,15,5))}.must_raise ArgumentError
    end
  end

  describe "date overlap" do
    it "checks if the dates are within the checkin/checkout date range" do
      start_date = Date.new(2001,2,4)
      end_date = Date.new(2001,2,10)
      @date.date_overlap?(start_date, end_date).must_equal true
    end

    it "should return false if only the start date is included in the date range" do
      start_date = Date.new(2001,2,4)
      end_date = Date.new(2001,2,17)
      @date.date_overlap?(start_date, end_date).must_equal true
    end

    it "checks if only the end date is included in the date range" do
      start_date = Date.new(2001,2,1)
      end_date = Date.new(2001,2,10)
      @date.date_overlap?(start_date, end_date).must_equal true
    end

    it "checks if the start and end dates are not included in the date range" do
      start_date = Date.new(2001,2,15)
      end_date = Date.new(2001,2,25)
      @date.date_overlap?(start_date, end_date).must_equal false
    end

    # it "should return false if start date is equal to the check_out date" do
    #   start_date = Date.new(2001,2,14)
    #   end_date = Date.new(2001,2,25)
    #   @date.date_overlap?(start_date, end_date).must_equal false
    # end
  end

end #end of describe block
