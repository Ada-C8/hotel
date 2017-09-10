require_relative 'spec_helper'

describe "DateRange" do

  let(:date) { BookingSystem::DateRange.new('2001-02-05', '2001-02-10') }
  let(:hotel) { BookingSystem::Hotel.new }

  describe "#initialize" do
    it "should create an instance of DateRange" do
      date.must_be_instance_of BookingSystem::DateRange

      date.must_respond_to :check_in
      date.check_in.must_be_instance_of Date

      date.must_respond_to :check_out
      date.check_out.must_be_instance_of Date
    end
  end # Describe

end # Describe
