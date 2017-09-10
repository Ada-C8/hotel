require_relative 'spec_helper'
require_relative '../lib/range'


describe 'Range' do

  it 'Can initialize check in and check out' do
    check_in = Date.new(2017, 02, 01)
    check_out = check_in + 2
    range = Property::Range.new(check_in, check_out)
    range.check_in.must_equal check_in
    range.check_out.must_equal check_out
  end

  it "cannot have a negative date range" do
    check_in = Date.new(2017, 02, 01)
    check_out = check_in - 5
    proc {Property::Range.new(check_in, check_out)}.must_raise Property::Range::InvalidDateRange
  end

  it "date range must not be 0" do
    check_in = Date.new(2017, 02, 01)
    check_out = check_in
    proc {Property::Range.new(check_in, check_out)}.must_raise Property::Range::InvalidDateRange
  end

  # it "returns true for valid date range " do
  #   check_in = Date.new(2017, 02, 01)
  #   check_out = check_in + 5
  #   @range = Property::Range.new(check_in, check_out)
  #   @range.valid?must_equal true
  # end

end

describe 'overlap?' do

  before do
    check_in = Date.new(2017, 2, 1)
    check_out = check_in + 3
    @range = Property::Range.new(check_in, check_out)
  end

  it "returns true for date range that overlaps neatly" do
    check_in = Date.new(2017, 2, 1)
    check_out = check_in + 3
    other_range = Property::Range.new(check_in, check_out)
    @range.overlap?(other_range).must_equal true
  end

  it "returns false for date range that doesn't overlap" do
    check_in = Date.new(2017, 5, 5)
    check_out = check_in + 3
    other_range = Property::Range.new(check_in, check_out)
    @range.overlap?(other_range).must_equal false
  end

  it "returns true for date range that overlaps for shorter reservations" do
    check_in = Date.new(2017, 2, 1)
    check_out = check_in + 1
    other_range = Property::Range.new(check_in, check_out)
    @range.overlap?(other_range).must_equal true
  end
    it "returns true for date range that overlaps for reservation with much earlier check in date" do
      check_in = Date.new(2017, 1, 1)
      check_out = Date.new(2017, 2, 2)
      other_range = Property::Range.new(check_in, check_out)
      @range.overlap?(other_range).must_equal true
  end

  it "returns true for date range that overlaps for longer reservations" do
    check_in = Date.new(2017, 2, 1)
    check_out = check_in + 27
    other_range = Property::Range.new(check_in, check_out)
    @range.overlap?(other_range).must_equal true
  end

end

describe 'num_nights' do

  it "returns the correct number of nights booked" do
    check_in = Date.new(2017, 5, 5)
    check_out = Date.new(2017, 5, 8)
    range = Property::Range.new(check_in, check_out)
    range.num_nights.must_equal 3
  end

  it "error for 0 nights" do
    check_in = Date.new(2017, 5, 5)
    check_out = check_in
  proc {Property::Range.new(check_in, check_out)}.must_raise Property::Range::InvalidDateRange
  end

end
