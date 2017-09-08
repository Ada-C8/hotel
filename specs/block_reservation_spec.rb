require_relative 'spec_helper'

describe "BlockReservation" do

  before do
    room = 1
    check_in = Date.new(2017,9,9)
    check_out = Date.new(2017,9,12)
    @test_ob = BookingSystem::BlockReservation.new(room, check_in, check_out)
  end

  describe "initialize method" do

    it "Can be initialized" do
      @test_ob.must_be_instance_of BookingSystem::BlockReservation
    end

    it "Has an instance variable @room" do
      @test_ob.room.must_equal 1
    end

    it "Has an instance variable @reservation_dates that is an instance of Date" do
      @test_ob.reservation_dates.must_be_instance_of Array
    end


  end

end
