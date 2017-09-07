require_relative 'spec_helper'

describe "DateRange class" do
  let(:check_in) {"Sept 9 2017"}
  let(:check_out) {"Sept 15 2017"}

  it "Can be instantiated" do
    Hotel::DateRange.new(check_in, check_out).must_be_instance_of Hotel::DateRange
  end

  it "Allows access to check_in instance variable" do
    new_hotel = Hotel::DateRange.new(check_in, check_out)
    new_hotel.check_in.must_be_instance_of Date
    new_hotel.check_out.must_be_instance_of Date
  end

  it "Checks for invalid date entry - if check in is after check out date" do
    check_in_1 = "Sept 9 2017"
    check_out_1 = "Sept 8 2017"
    proc {Hotel::DateRange.new(check_in_1, check_out_1)}.must_raise ArgumentError
  end


end
