require_relative 'spec_helper'

describe "Hotel class" do

  describe "UnavailableRoomError class" do

    it "Can be instantiated" do
      BookingSystem::Hotel::UnavailableRoomError.new.must_be_instance_of BookingSystem::Hotel::UnavailableRoomError
    end

  end

  before do
    @test_ob = BookingSystem::Hotel.new
    @room = 1
    @check_in = Date.new(2017,9,9)
    @check_out = Date.new(2017,9,12)
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

    it "Has an instance variable @all_single_reservations that holds objects (instances of Reservation class) in an Array" do
      @test_ob.all_single_reservations.must_be_instance_of Array
    end

    it "Has an instance variable @all_blocks that holds objects (instances of Block class) in an Array" do
      @test_ob.all_blocks.must_be_instance_of Array
    end
  end#initialize

  describe "make_reservation method" do

    it "Can be called" do
      @test_ob.must_respond_to :make_reservation
    end

    it "Returns an instance of Reservation class when room is available" do
      @test_ob.make_reservation(@room, @check_in, @check_out).must_be_instance_of BookingSystem::Reservation
    end

    it "Increases @all_single_reservations by 1 for each new reservation" do
      @test_ob.make_reservation(@room, @check_in, @check_out)
      @test_ob.all_single_reservations.length.must_equal 1
    end

    it "Raises an UnavailableRoomError if room is unavailable" do
      @test_ob.make_reservation(@room, @check_in, @check_out)

      proc { @test_ob.make_reservation(@room, @check_in, @check_out) }.must_raise BookingSystem::Hotel::UnavailableRoomError
    end

  end

  describe "block_off_a_block method" do

    it "Can be called" do
      @test_ob.must_respond_to :block_off_a_block
    end

    it "Raises an UnavailableRoomError if there are not enough rooms available for request" do
      @test_ob.make_reservation(@room, @check_in, @check_out)
      proc { @test_ob.block_off_a_block(20, @check_in, @check_out) }.must_raise BookingSystem::Hotel::UnavailableRoomError
    end

    it "Returns an instance of Block class" do
      @test_ob.block_off_a_block(3, @check_in, @check_out).must_be_instance_of BookingSystem::Block
    end

    it "Increases the length of the @block_reservations by 1" do
      @test_ob.block_off_a_block(3, @check_in, @check_out)
      @test_ob.all_blocks.length.must_equal 1
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

      block_check_in = Date.new(2017,10,9)
      block_check_out = Date.new(2017,10,12)

      @test_ob.make_reservation(@room, @check_in, @check_out)

      @test_ob.send(:room_available?, @room, @check_in, @check_out).must_equal false

      @test_ob.block_off_a_block(5, block_check_in, block_check_out)

      @test_ob.send(:room_available?, 1, block_check_in, block_check_out).must_equal false
    end
  end

end
