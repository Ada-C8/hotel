require_relative 'spec_helper'

describe "DateRange class" do
  # let(:check_in) {Date.new(2017, 9, 4)}
  # let(:check_out) {Date.new(2017, 9, 9)}

  #no longer needed because changed the structure of my initialize parameters
  # it "Can be instantiated" do
  #   # check_in = Date.new(2017, 9, 4)
  #   # check_out = Date.new(2017, 9, 9)
  #   Hotel::DateRange.new(check_in, check_out).must_be_instance_of Hotel::DateRange
  # end

  it "Can be instantiated" do
    Hotel::DateRange.new(2017, 9, 4, 2017, 9, 9).must_be_instance_of Hotel::DateRange
  end

  it "Allows access to check_in instance variable" do
    new_hotel = Hotel::DateRange.new(2017, 9, 4, 2017, 9, 9)
    new_hotel.check_in.must_be_instance_of Date
    new_hotel.check_out.must_be_instance_of Date
  end


end
