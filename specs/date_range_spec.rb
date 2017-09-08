require_relative 'spec_helper'

describe "DateRange" do
  before do
    @check_in = Date.new(2017,9,15)
    @check_out = Date.new(2017,9,17)
    @new_date_range = BookingSystem::DateRange.new(@check_in, @check_out)
    @past_date = Date.new(2015,5,3)
  end

  describe "#initialize" do
    it "Check_in and check_out values are types of Date class" do
      @new_date_range.check_in.must_be_kind_of Date
      @new_date_range.check_out.must_be_kind_of Date
    end
    it "Raise an error if check_in or check_out values are not types of Date class" do
      proc { BookingSystem::DateRange.new("2017-9-15", "2017-9-17") }.must_raise BookingSystem::InvalidDate
    end
    it "Raise an error if given check_out date is before check_in date" do
      proc { BookingSystem::DateRange.new(@check_out, @check_in) }.must_raise BookingSystem::InvalidDate
    end
    it "Raise an error if given date is in the past" do
      proc { BookingSystem::DateRange.new(@past_date, @check_out) }.must_raise BookingSystem::InvalidDate
    end
  end

  describe "dates_within_range" do
    it "Returns an array" do
      @new_date_range.dates_within_range.must_be_kind_of Array
    end
    it "Returns the array of right length for short ranges" do
      @new_date_range.dates_within_range.length.must_equal 2
    end
    it "Returns the array of right length for long ranges" do
      check_in = Date.new(2017,9,15)
      check_out = Date.new(2017,10,15)
      BookingSystem::DateRange.new(check_in, check_out).dates_within_range.length.must_equal 30
    end
  end

end #end of discribe
