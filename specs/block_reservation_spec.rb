require_relative 'spec_helper'

describe "BlockReservation" do
  before do
    room = 1
    check_in = Date.new(2017,9,9)
    check_out = Date.new(2017,9,12)
    @test_ob = BookingSystem::BlockReservation.new(room, check_in, check_out)
  end

  it "Has a constant DISCOUNT_RATE assigned to 0.15" do
    BookingSystem::BlockReservation::DISCOUNT_RATE.must_equal 0.15
  end

  describe "initialize method" do
    it "Can be initialized" do
      @test_ob.must_be_instance_of BookingSystem::BlockReservation
    end

    it "Has an instance variable @room" do
      @test_ob.room.must_equal 1
    end

    it "Has instance variable price set to default 200" do
      @test_ob.price.must_equal 200
    end

    it "price parameter can accept other values for the price attribute" do
      room = 2
      check_in = Date.new(2017,9,9)
      check_out = Date.new(2017,9,12)
      price = 100
      @test_ob_2 = BookingSystem::Reservation.new(room, check_in, check_out, price)

      @test_ob_2.price.must_equal 100
    end

    it "Has an instance variable @reservation_dates that is an instance of Date" do
      @test_ob.reservation_dates.must_be_instance_of Array
    end
  end

  describe "discount_price method" do
    it "Can be called" do
      @test_ob.must_respond_to :discount_price
    end
    
    it "Returns a Float" do
      @test_ob.discount_price.must_be_instance_of Float
    end
  end

  describe "total_cost method" do
    it "Can be called" do
      @test_ob.must_respond_to :total_cost
    end

    it "Returns a Float" do
      @test_ob.total_cost.must_be_instance_of Float
    end
  end

end
