require_relative 'spec_helper'

describe "DateRange" do
  before do
    @check_in = Date.new(2017,9,15)
    @check_out = Date.new(2017,9,17)
    @new_date_range = BookingSystem::DateRange.new(@check_in, @check_out)
  end

  describe "#initialize" do
    it "Check_in and check_out values are types of Date class" do
      @new_date_range.check_in.must_be_kind_of Date
      @new_date_range.check_out.must_be_kind_of Date
    end
    it "Raise an error if check_in or check_out values are not types of Date class" do
      proc { BookingSystem::DateRange.new("2017-9-15", "2017-9-17") }.must_raise ArgumentError
    end
    it "Raise an error if given check_out date is before check_in date" do
      proc { BookingSystem::DateRange.new(@check_out, @check_in) }.must_raise ArgumentError
    end
  end

  # xdescribe "#valid_dates?" do
  #   it "Returns true if given check_out date is after check_in date" do
  #     @new_date_range.valid_dates?.must_equal true
  #   end
  #   it "Returns false if given check_out date is before check_in date" do
  #     date_range = BookingSystem::DateRange.new("17-09-2017", "15-09-2017")
  #     proc { date_range.valid_dates? }.must_raise ArgumentError
  #   end
  # end
  #
  # xdescribe "dates_within_range" do
  #   it "Returns an array" do
  #     @new_date_range.dates_within_range.must_be_kind_of Array
  #   end
  #   it "Returns an array of dates within the given range" do
  #     @new_date_range.dates_within_range.must_equal [a, b, c]
  #   end
  # end



end #end of discribe
