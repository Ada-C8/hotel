require_relative 'spec_helper'

describe "DateRange Class" do
  before do
    @date_range_test = Hotel::DateRange.new("2017-9-12", "2017-9-15")
  end
  describe "Initialize DateRange Class" do
    it "DateRange.new is an instance of Hotel module" do
      @date_range_test.must_be_instance_of Hotel::DateRange
    end
    it "Responds to check_in variable" do
      @date_range_test.must_respond_to :check_in
    end
    it "Responds to check_out variable" do
      @date_range_test.must_respond_to :check_out
    end
    it "Responds to number_of_nights variable" do
      @date_range_test.must_respond_to :number_of_nights
    end
    it "Equals number_of_nights" do
      @date_range_test.number_of_nights.must_equal 3
    end
    it "raises an ArgumentError if check_in date has passed" do
      proc {
        Hotel::DateRange.new("2017-9-1", "2017-9-12")
      }.must_raise ArgumentError
    end
    it "raises an ArgumentError if check_out date is before check_in date" do
      proc {
        Hotel::DateRange.new("2017-9-15", "2017-9-12")
      }.must_raise ArgumentError
    end
  end # end of describe Initialize DateRange Class
  describe "Overlap? method" do
    it "Checks for overlapping dates" do
      @date_range_test = Hotel::DateRange.new("2017-9-12", "2017-9-15")
      @date_range_test.overlap?("2017-9-13", "2017-9-14").must_equal true
      @date_range_test.overlap?("2017-9-16", "2017-9-17").must_equal false
    end
  end
  describe "Return_date_range method" do
    it "Returns to a string" do
      @date_range_test.return_date_range.must_be_kind_of String
    end
  end # end of describe return_date_range method
end # end of describe DateRange class
