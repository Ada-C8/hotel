require_relative "spec_helper"

describe "DateRange class" do
  it "initializes a check_in and check_out date" do
    Hotel::DateRange.new("10-15-2020","10-17-2020")
  end
  it "raises an error if date is in the past" do
    proc { Hotel::DateRange.new("8-17-2017","8-20-2017") }.must_raise ArgumentError
  end
  it "raises an error if dates aren't in ascending order" do
    proc { Hotel::DateRange.new("12-17-2017","12-5-2017") }.must_raise ArgumentError
  end
  it "raises an error if it doesn't match formatting" do
    proc { Hotel::DateRange.new("12-1-17","12-5-2017") }.must_raise ArgumentError
  end
  it "returns an array for date range method" do
    dates = Hotel::DateRange.new("10-15-2020","10-17-2020")
    dates.date_range.must_be_kind_of Array
  end
end
