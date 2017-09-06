require_relative 'spec_helper'

describe "Reservation class" do

  before do
    check_in = Date.new(2017,9,9)
    check_out = Date.new(2017,9,12)
    @test_ob = BookingSystem::Reservation.new(1, check_in, check_out)
  end

  it "Has a ROOM_PRICE constant that is assigned to the integer 200" do
    BookingSystem::Reservation::ROOM_PRICE.must_equal 200
  end

  describe "initialize method" do

    it "Can be instantiated" do
      @test_ob.must_be_instance_of BookingSystem::Reservation
    end

    it "Has an instance variable @reservation_dates which is an Array of Date objects" do
      @test_ob.reservation_dates.must_be_instance_of Array
      @test_ob.reservation_dates[0].must_be_instance_of Date
    end

    it "Has an instance variable @room which is an Integer" do
      @test_ob.room.must_be_instance_of Integer
    end

    it "Raises InvalidRoomError if room argument is not an Integer between 1-20" do
      check_in = Date.new(2017,9,12)
      check_out = Date.new(2017,9,12)

      proc { BookingSystem::Reservation.new("one", check_in, check_out) }.must_raise BookingSystem::Reservation::InvalidRoomError

      proc { BookingSystem::Reservation.new(0, check_in, check_out) }.must_raise BookingSystem::Reservation::InvalidRoomError

      proc { BookingSystem::Reservation.new(21, check_in, check_out) }.must_raise BookingSystem::Reservation::InvalidRoomError
    end



  end

end
