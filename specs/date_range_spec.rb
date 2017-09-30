require_relative 'spec_helper'

describe "DateRange" do
  before do
    @checkin = Date.new(2017, 01, 01)
    @checkout = Date.new(2017, 01, 04)
    @range = Booking::DateRange.new(@checkin, @checkout)
  end

  describe "initialize" do
    it "Should create an instance of a DateRange" do
      @range.must_be_kind_of Booking::DateRange
    end

    it " checkin and checkout should be an instance of a Date class" do
      @range.end_date.must_be_kind_of Date
      @range.start_date.must_be_kind_of Date
    end

    it " should raise an error if checkin date is greater than checkout" do
      proc {
        checkin = Date.new(2017, 01, 04)
        checkout = Date.new(2017, 01, 01)
        Booking::DateRange.new(checkin, checkout)
      }.must_raise ArgumentError
    end

    it "should raise an error if checkin or checkout aren't Date objects " do
      proc {
        checkin = "2017, 01, 04"
        checkout = "2017, 01, 01"
        Booking::DateRange.new(checkin, checkout)
      }.must_raise ArgumentError

      proc {
        checkin = Date.new(2017, 01, 04)
        checkout = nil
        Booking::DateRange.new(checkin, checkout)
      }.must_raise ArgumentError

      proc {
        checkin = 2017374527354
        checkout = Date.new(2017, 01, 01)
        Booking::DateRange.new(checkin, checkout)
      }.must_raise ArgumentError
    end

  end
  describe "is_included? method" do
    it "checks if the date is included inside of a date_range" do
      date1 = Date.new(2017,01,02)
      date2 = Date.new(2017,01,04)
      @range.is_included?(date1).must_equal true
      @range.is_included?(date2).must_equal false
    end
  end

  describe "number_of_nights method" do
    it "should return the number of nights customer stayed at the hotel" do
      @range.number_of_nights.must_equal (@checkout - @checkin) #3
    end
  end



end
