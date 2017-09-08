require_relative 'spec_helper'

describe "DateRange" do

  before do
    check_in = '2001-02-05'
    check_out = '2001-02-10'
    @booking = BookingSystem::DateRange.new(check_in, check_out)
  end

  describe "#initialize" do
    it "should create an instance of DateRange" do
      @booking.must_be_instance_of BookingSystem::DateRange

      @booking.must_respond_to :check_in
      @booking.check_in.must_be_instance_of Date

      @booking.must_respond_to :check_out
      @booking.check_out.must_be_instance_of Date
    end
  end # Describe

  # describe "#overlap" do
  #   it "should return an Array of Integers" do
  #
  #   end
  # end

end # Describe
