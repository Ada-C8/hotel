require_relative 'spec_helper'

describe "Reservation class" do

  before do
    check_in = Date.new(2017,9,9)
    check_out = Date.new(2017,9,12)
    @test_ob = BookingSystem::Reservation.new(1, check_in, check_out)
  end

  describe "initialize method" do

    it "Can be instantiated" do
      @test_ob.must_be_instance_of BookingSystem::Reservation
    end

    it "Has an instance variable @reservation_dates which is an array of Date objects" do
      @test_ob.reservation_dates.must_be_instance_of Array
      @test_ob.reservation_dates[0].must_be_instance_of Date
    end

    it "Has an instance variable @room which is an integer" do
      @test_ob.room.must_be_instance_of Integer
    end

  end

end
