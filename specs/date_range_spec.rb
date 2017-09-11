# Testing for date_range
# Edited 9/5/17
require_relative 'spec_helper'

describe "Date Range" do

  describe "initialize method" do
    it "takes checkin and checkout dates" do
      checkin_date = Date.new(2001,2,5)
      checkout_date = Date.new(2001,2,14)
      date = Hotel::DateRange.new(checkin_date, checkout_date)

      date.must_be_instance_of Hotel::DateRange
    end

    it "should set checkin and checkout dates appropriately" do
      checkin_date = Date.new(2001,2,5)
      checkout_date = Date.new(2001,2,14)
      date = Hotel::DateRange.new(checkin_date, checkout_date)

      date.checkin_date.must_equal checkin_date
      date.checkout_date.must_equal checkout_date
    end

    it "raises an argument error for invalid checkin_date" do
      checkin_date = nil
      checkout_date = Date.new(2001,2,14)

      proc{Hotel::DateRange.new(checkin_date, checkout_date)}.must_raise ArgumentError

      checkin_date = ""
      checkout_date = Date.new(2001,2,14)

      proc{Hotel::DateRange.new(checkin_date, checkout_date)}.must_raise ArgumentError

      checkin_date = "8/12/2013"
      checkout_date = Date.new(2001,2,14)

      proc{Hotel::DateRange.new(checkin_date, checkout_date)}.must_raise ArgumentError
    end

    it "raises an argument error for invalid checkout_date" do
      checkin_date = Date.new(2001,2,14)
      checkout_date = ""
      proc{Hotel::DateRange.new(checkin_date, checkout_date)}.must_raise ArgumentError
    end

    it "checks that checkin must be before checkout" do
      checkin_date = Date.new(2001,2,14)
      checkout_date = Date.new(2001,2,5)
      proc{Hotel::DateRange.new(checkin_date, checkout_date)}.must_raise ArgumentError
    end
  end

  describe "With a valid DateRange" do

    before do
      @checkin_date = Date.new(2001,2,3)
      @checkout_date = Date.new(2001,2,14)
      @date = Hotel::DateRange.new(@checkin_date, @checkout_date)
    end

    describe "date include" do
      it "checks if a date is included in the date range" do
        start_date = Date.new(2001,2,3)
        end_date = Date.new(2001,2,6)
        date_range = Hotel::DateRange.new(start_date, end_date)
        @date.date_include?(date_range).must_equal true

        start_date = Date.new(2001,2,5)
        end_date = Date.new(2001,2,14)
        date_range = Hotel::DateRange.new(start_date, end_date)
        @date.date_include?(date_range).must_equal true

        start_date = Date.new(2001,1,28)
        end_date = Date.new(2001,2,3)
        date_range = Hotel::DateRange.new(start_date, end_date)
        @date.date_include?(date_range).must_equal false

        start_date = Date.new(2001,2,14)
        end_date = Date.new(2001,2,18)
        date_range = Hotel::DateRange.new(start_date, end_date)
        @date.date_include?(date_range).must_equal false

        start_date = Date.new(2001,2,15)
        end_date = Date.new(2001,2,17)
        date_range = Hotel::DateRange.new(start_date, end_date)
        @date.date_include?(date_range).must_equal false

        start_date = Date.new(2001,1,21)
        end_date = Date.new(2001,1,28)
        date_range = Hotel::DateRange.new(start_date, end_date)
        @date.date_include?(date_range).must_equal false
      end
    end

    describe "date overlap" do
      it "checks if the dates are within the checkin/checkout date range" do
        start_date = Date.new(2001,2,4)
        end_date = Date.new(2001,2,10)
        date_range = Hotel::DateRange.new(start_date, end_date)
        @date.date_overlap?(date_range).must_equal true
      end

      it "should return false if only the start date is included in the date range" do
        start_date = Date.new(2001,2,4)
        end_date = Date.new(2001,2,17)
        date_range = Hotel::DateRange.new(start_date, end_date)
        @date.date_overlap?(date_range).must_equal true
      end

      it "checks if only the end date is included in the date range" do
        start_date = Date.new(2001,2,1)
        end_date = Date.new(2001,2,10)
        date_range = Hotel::DateRange.new(start_date, end_date)
        @date.date_overlap?(date_range).must_equal true
      end

      it "checks if the start and end dates are not included in the date range" do
        start_date = Date.new(2001,2,15)
        end_date = Date.new(2001,2,25)
        date_range = Hotel::DateRange.new(start_date, end_date)
        @date.date_overlap?(date_range).must_equal false
      end

      # it "should return false if start date is equal to the check_out date" do
      #   start_date = Date.new(2001,2,14)
      #   end_date = Date.new(2001,2,25)
      #   @date.date_overlap?(start_date, end_date).must_equal false
      # end
    end
  end# end of valid date range

end #end of describe block
