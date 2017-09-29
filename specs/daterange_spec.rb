require_relative 'spec_helper'

require 'pry'

describe Hotel::DateRange do
  describe "an instance of DateRange can be created" do
    before do
      @check_in = Date.new(2018, 10, 5)
      @check_out = Date.new(2018, 10, 7)
      @date_range = Hotel::DateRange.new(@check_in, @check_out)
    end
    it "can be created" do
      @date_range.must_be_instance_of Hotel::DateRange
    end

    it "has a check-in, check_out" do
      @date_range.check_in.must_equal @check_in
      @date_range.check_out.must_equal @check_out
    end

    it "accurately calculates the total nights included" do
      @date_range.total_nights.must_equal 2
    end

    it "returns and error if the check in date is after the check in date or if the check in date is before today" do
      proc{Hotel::DateRange.new(Date.today - 1, Date.new(2017, 12, 25))}.must_raise ArgumentError

      proc{Hotel::DateRange.new(Date.new(2017, 12, 26), Date.new(2017, 12, 25))}.must_raise ArgumentError
    end
  end

  describe "overlap" do
    before do
      @dr1 = Hotel::DateRange.new(Date.new(2018, 1, 1),(Date.new(2018, 1, 20)))

      @dr2 = Hotel::DateRange.new(Date.new(2018, 1, 5),(Date.new(2018, 1, 15)))

      @dr3 = Hotel::DateRange.new(Date.new(2018, 1, 17),(Date.new(2018, 1, 20)))
    end

    it "returns an array" do
      @dr1.overlap(@dr2).must_be_kind_of Array
    end

    it "returns an empty array if no dates overlap" do
      @dr2.overlap(@dr3).empty?.must_equal true
    end

    it "returns a non-empty array if some dates overlap" do
      @dr1.overlap(@dr3).empty?.must_equal false
    end

  end

end
