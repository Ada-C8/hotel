require_relative 'spec_helper'

describe "DateRange Class" do
  before do
    check_in = Date.new(2017,9,5)
    check_out = Date.new(2017,9,8)
    @vacation = Hotel::DateRange.new(check_in,check_out)
  end
  # will respond to @check_in, @check_out
  #will create a new instance of date_range that will output an array
  #will validate inputs
  describe "initialize" do
    it "Instance of DateRange class must respond to check_in and check_out" do
      @vacation.must_respond_to :check_in
      @vacation.must_respond_to :check_out
    end
    it "check_in and check_out are of the Date class" do
      @vacation.check_in.must_be_kind_of Date
      @vacation.check_out.must_be_kind_of Date
    end
  end
  describe "make_nights_arr method" do

  end
end
