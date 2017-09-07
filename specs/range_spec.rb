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

end

describe "valid?" do

  it "cannot have a negative date range" do
    check_in = Date.new(2017, 02, 01)
    check_out = check_in - 5
    proc {Property::Range.new(check_in, check_out).valid?}.must_raise ArgumentError
  end

  it "date range must not be 0" do
    check_in = Date.new(2017, 02, 01)
    check_out = check_in
    proc {Property::Range.new(check_in, check_out).valid?}.must_raise ArgumentError
  end

  it "returns true for valid date range " do
    check_in = Date.new(2017, 02, 01)
    check_out = check_in + 5
    @range = Property::Range.new(check_in, check_out)
    @range.valid?.must_equal true
  end

end

describe 'overlap?' do

  before do
    check_in = Date.new(2017, 02, 01)
    check_out = check_in + 3
    @range = Property::Range.new(check_in, check_out)
  end

  it "returns true for date range that overlaps" do
    check_in = Date.new(2017, 02, 01)
    check_out = check_in + 3
    other_range = Property::Range.new(check_in, check_out)
    @range.overlap?(other_range).must_equal true
  end

  it "returns false for date range that doesn't overlap" do
    check_in = Date.new(2017, 05, 05)
    check_out = check_in + 3
    other_range = Property::Range.new(check_in, check_out)
    @range.overlap?(other_range).must_equal false
  end
end
