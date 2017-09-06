require_relative 'spec_helper'

describe "DateRange Class" do
  before do
    check_in = Date.new(2017,9,5)
    check_out = Date.new(2017,9,8)
    # check_out_bad = Date.new(2017,9,2)
    @vacation = Hotel::DateRange.new(check_in,check_out)
    @vacation_bad_dates = Hotel::DateRange.new(check_out,check_in)
  end
  # will respond to @check_in, @check_out
  #will create a new instance of date_range that will output an array
  #will validate inputs
  describe "initialize" do
    it "Instance of DateRange class must respond to instance variables (check_in,check_out,nights, nights_arr" do
      @vacation.must_respond_to :check_in
      @vacation.must_respond_to :check_out
      @vacation.must_respond_to :nights
      @vacation.must_respond_to :nights_arr
    end
    it "check_in and check_out are of the Date class" do
      @vacation.check_in.must_be_kind_of Date
      @vacation.check_out.must_be_kind_of Date
    end
    it "nights is an Integer" do
      @vacation.nights.must_be_kind_of Integer
    end
    it "nights returns the correct number equal to the difference of checkout-checkin" do
      @vacation.nights.must_equal 3
    end
    it "nights_arr is an array" do
      @vacation.nights_arr.must_be_kind_of Array
    end
  end
  describe "valid_date? method" do
    it "valid_date? will raise an error if check_out if prior to check_in" do
      check_in = Date.new(2017,9,5)
      check_out = Date.new(2017,9,8)
      trip = Hotel::DateRange.new(check_out,check_in)
      proc{trip.valid_date?}.must_raise InvalidDateRangeError
    end
  end
  describe "make_nights_arr method" do
    it "returns array" do
      @vacation.make_nights_arr.must_be_kind_of Array
    end
    it "increase the size of instance variable @nights_arr" do
      before = @vacation.nights_arr.length
      # before.must_equal 0
      @vacation.make_nights_arr
      after = @vacation.nights_arr.length
      after.must_be :>, before
      after.must_equal @vacation.nights
    end
    it "will generate an array that has a length equal to nights" do
      @vacation.make_nights_arr.length.must_equal @vacation.nights
    end
    it "nested method valid_date? will raise exception if checkout is prior to checkin" do
      check_in = Date.new(2017,9,5)
      check_out = Date.new(2017,9,8)
      trip = Hotel::DateRange.new(check_out,check_in)
      proc{trip.make_nights_arr}.must_raise InvalidDateRangeError
    end
  end
end
