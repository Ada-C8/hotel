require_relative 'spec_helper'

describe "Hotel class" do

  describe "UnavailableRoomError class" do

    it "Can be instantiated" do
      BookingSystem::Hotel::UnavailableRoomError.new.must_be_instance_of BookingSystem::Hotel::UnavailableRoomError
    end

  end

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

    it "Raises an UnavailableRoomError if room is unavailable" do
      @test_ob.make_reservation(@room, @check_in, @check_out)

      proc { @test_ob.make_reservation(@room, @check_in, @check_out) }.must_raise BookingSystem::Hotel::UnavailableRoomError
    end

  end

  describe "block_reservation" do

    it "Can be called" do
      @test_ob.must_respond_to :block_reservation
    end
  end

  describe "reservations_for_specific_date" do

    before do
      @room = 1
      @check_in = Date.new(2017,9,9)
      @check_out = Date.new(2017,9,12)
    end

    it "Can be called" do
      @test_ob.must_respond_to :reservations_for_specific_date
    end

    it "Returns an array of Reservation objects" do
      @test_ob.make_reservation(@room, @check_in, @check_out)

      @test_ob.make_reservation(2, Date.new(2017,9,11), Date.new(2017,9,15))

      @test_ob.reservations_for_specific_date(Date.new(2017,9,10)).must_be_instance_of Array

      @test_ob.reservations_for_specific_date(Date.new(2017,9,10))[0].must_be_instance_of BookingSystem::Reservation

      @test_ob.reservations_for_specific_date(Date.new(2017,9,11)).length.must_equal 2
    end
  end

  describe "available_rooms method" do

    before do
      @room = 1
      @check_in = Date.new(2017,9,9)
      @check_out = Date.new(2017,9,12)
    end

    it "Can be called" do
      @test_ob.must_respond_to :available_rooms
    end

    it "Returns an Array of Integers" do
      @test_ob.available_rooms(@check_in, @check_out).must_be_instance_of Array

      @test_ob.available_rooms(@check_in, @check_out)[0].must_be_instance_of Integer

      @test_ob.available_rooms(@check_in, @check_out).length.must_equal 20

      @test_ob.make_reservation(@room, @check_in, @check_out)
      @test_ob.available_rooms(@check_in, @check_out).length.must_equal 19

    end

  end

  describe "room_available? method" do
    before do
      @room = 1
      @check_in = Date.new(2017,9,9)
      @check_out = Date.new(2017,9,12)
    end

    #https://stackoverflow.com/questions/16599256/testing-private-method-in-ruby-rspec
    it "Returns true if room is available for requested dates" do
      @test_ob.send(:room_available?, @room, @check_in, @check_out).must_equal true
    end

    it "Returns false if room is not available for requested dates" do

      @test_ob.make_reservation(@room, @check_in, @check_out)

      @test_ob.send(:room_available?, @room, @check_in, @check_out).must_equal false
    end
  end

end
