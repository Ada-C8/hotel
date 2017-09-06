require_relative 'spec_helper'

describe "Hotel class" do

  before do
    @test_ob = BookingSystem::Hotel.new
  end

  describe "initalize method" do

    it "Can create a Hotel object" do
      @test_ob.must_be_instance_of BookingSystem::Hotel
    end

    it "Has an instance variable @rooms of all rooms stored as an array" do
      @test_ob.rooms.must_be_instance_of Array
    end

    it "@rooms method holds Integers 1 to 20" do
      @test_ob.rooms[0].must_equal 1
      @test_ob.rooms[19].must_equal 20
    end

    it "Has an instance variable @all_reservations that holds objects (instances of Reservation class) in an Array" do
      @test_ob.all_reservations.must_be_instance_of Array
    end

  end#initialize

  describe "available_rooms method" do

    it "Can be called" do
      @test_ob.must_respond_to :available_rooms
    end

    it "Returns an Array" do
      @test_ob.available_rooms.must_be_instance_of Array
    end

  end

  describe "make_reservation method" do

    before do
      @room = 1
      @check_in = Date.new(2017,9,9)
      @check_out = Date.new(2017,9,12)
    end

    it "Can be called" do
      @test_ob.must_respond_to :make_reservation
    end

    it "Returns an instance of Reservation class" do
      @test_ob.make_reservation(@room, @check_in, @check_out).must_be_instance_of BookingSystem::Reservation
    end

    it "Increases @all_reservations by 1" do
      @test_ob.make_reservation(@room, @check_in, @check_out)
      @test_ob.all_reservations.length.must_equal 1
    end

  end

end
