require_relative 'spec_helper'

describe 'DateRange' do

  before(:all) do
    @check_in = Date.new(2018, 03, 11)
    @check_out = Date.new(2018, 03, 15)
  end

  describe "initialize" do
    it "creates a new instance of DateRange" do
      Hotel::DateRange.new(@check_in, @check_out).must_be_instance_of Hotel::DateRange
    end

    it "raises an argument error if check_out date is before check_in" do
      check_in = Date.new(2018, 04, 11)
      proc { Hotel::DateRange.new(check_in, @check_out)}.must_raise ArgumentError
    end

    it "does not raise an argument error if check_out date is after check_in" do
      check_out = Date.new(2018, 04, 11)
      Hotel::DateRange.new(@check_in, check_out).must_be_instance_of Hotel::DateRange
    end

    it "raises an argument error if check_in is a day that has already passed" do
      check_in = Date.new(2016, 11, 03)
      proc { Hotel::DateRange.new(check_in, @check_out)}.must_raise ArgumentError
    end
  end

  describe "nights" do
    it "returns the nights of the stay" do
      stay = Hotel::DateRange.new(@check_in, @check_out)
      stay.nights.must_equal 4
    end
  end

  describe "include?" do
    it "returns true if date is included in range" do
      date_to_check = Date.new(2018, 03, 12)
      stay = Hotel::DateRange.new(@check_in, @check_out)
      stay.include?(date_to_check).must_equal true
    end

    it "returns false if date is not included in range" do
      date_to_check = Date.new(2018, 03, 27)
      stay = Hotel::DateRange.new(@check_in, @check_out)
      stay.include?(date_to_check).must_equal false
    end

    it "returns true if date_to_check is same as check-in" do
      date_to_check = Date.new(2018, 03, 11)
      stay = Hotel::DateRange.new(@check_in, @check_out)
      stay.include?(date_to_check).must_equal true
    end

    # tests that range excludes last day (i.e., the checkout day)
    it "returns false if date_to_check is same as check-out day" do
      date_to_check = Date.new(2018, 03, 15)
      stay = Hotel::DateRange.new(@check_in, @check_out)
      stay.include?(date_to_check).must_equal false
    end
  end

  describe "overlap?" do
    it "returns true if date ranges overlap completely" do
      check_in = Date.new(2018, 03, 8)
      check_out = Date.new(2018, 03, 22)
      stay = Hotel::DateRange.new(check_in, check_out)
      stay.overlap?(@check_in, @check_out).must_equal true
    end

    it "returns true if date ranges overlap partially" do
      check_in = Date.new(2018, 03, 13)
      check_out = Date.new(2018, 03, 17)
      stay = Hotel::DateRange.new(check_in, check_out)
      stay.overlap?(@check_in, @check_out).must_equal true
    end

    it "returns false if date ranges do not overlap at all" do
      check_in = Date.new(2018, 03, 17)
      check_out = Date.new(2018, 03, 22)
      stay = Hotel::DateRange.new(check_in, check_out)
      stay.overlap?(@check_in, @check_out).must_equal false
    end

    # can check in on the same day someone else checks out (i.e., they don't overlap)
    it "returns false if one date range's check-in day is the same as the other date range's check-out day" do
      check_in = Date.new(2018, 03, 15)
      check_out = Date.new(2018, 03, 22)
      stay = Hotel::DateRange.new(check_in, check_out)
      stay.overlap?(@check_in, @check_out).must_equal false
    end
  end

end
