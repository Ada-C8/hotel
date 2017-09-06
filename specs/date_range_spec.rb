require_relative 'spec_helper'

describe "DateRange" do

  before do
    check_in = '2001-02-03'
    check_out = '2001-02-04'
    @booking = BookingSystem::DateRange.new(check_in, check_out)
  end

  describe "#initialize" do
    it "should create an instance of DateRange" do
      @booking.must_be_instance_of BookingSystem::DateRange
    end
  end # Describe

end # Describe
