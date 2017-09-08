require_relative '../specs/spec_helper'

=begin
- the date range class will be instanciated in the Admin class.
1. initialize the method with a start date and and end date.
2. Does the range of dates have a reservation?
3.



=end

describe "DateRange class" do
  before do
    check_in = Date.new(2017,2,3)
    check_out = Date.new(2017, 2,7)
    @date_range = Hotel::DateRange.new(check_in, check_out)
  end
  describe "initialize" do

    it "Takes a start date object" do
      check_in = Date.new(2017,2,3)
      check_out = Date.new(2017, 2,7)
      Hotel::DateRange.new(check_in, check_out).must_respond_to :check_in
    end

    it "Takes an end date object" do
      check_in = Date.new(2017,2,3)
      check_out = Date.new(2017, 2,7)
      Hotel::DateRange.new(check_in, check_out).must_respond_to :check_out
    end

    it "Returns array of dates in range" do
      @date_range.date_range_array.must_be_instance_of Array
    end

    it "Raises an error for invalid date ranges" do
      check_in = Date.new(2017, 2, 3)
      check_out = Date.new(2015, 2, 7)
      proc{Hotel::DateRange.new(check_in, check_out)}.must_raise ArgumentError
    end

    it "Returns a DateRange object" do
      @date_range.must_be_instance_of Hotel::DateRange
    end

  end # end initialize

  describe "over lap method" do
    it "text" do

    end
  end


end # end date range class
