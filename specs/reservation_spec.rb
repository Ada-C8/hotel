require_relative 'spec_helper'

describe "Reservation class" do
  describe "InvalidRoomError class" do
    it "Can be instantiated" do
      BookingSystem::Reservation::InvalidRoomError.new.must_be_instance_of BookingSystem::Reservation::InvalidRoomError
    end
  end

  describe "InvalidPriceError class" do
    it "Can be instantiated" do
      BookingSystem::Reservation::InvalidPriceError.new.must_be_instance_of BookingSystem::Reservation::InvalidPriceError
    end
  end

  before do
    room = 1
    check_in = Date.new(2017,9,9)
    check_out = Date.new(2017,9,12)
    price = 200
    @test_ob = BookingSystem::Reservation.new(room, check_in, check_out, price)
  end

  describe "initialize method" do
    it "Can be instantiated" do
      @test_ob.must_be_instance_of BookingSystem::Reservation
    end

    it "Has an instance variable @reservation_dates which is an Array of Date objects" do
      @test_ob.reservation_dates.must_be_instance_of Array
      @test_ob.reservation_dates[0].must_be_instance_of Date
    end

    it "Has an instance variable @room which is an Integer between 1-20" do
      @test_ob.room.must_be_instance_of Integer
    end

    it "Has an instance variable @price that is an Integer" do
      @test_ob.price.must_be_instance_of Integer
    end
  end

  describe "total_cost method" do
    it "Can be called" do
      @test_ob.must_respond_to :total_cost
    end

    it "Returns the total cost of the reservation as an Integer" do
      default_room_price = 200
      length_of_stay = 3 #2017,9,9; 2017,9,10; 2017,9,11
      total_cost = default_room_price * length_of_stay
      @test_ob.total_cost.must_equal total_cost
    end
  end
end
