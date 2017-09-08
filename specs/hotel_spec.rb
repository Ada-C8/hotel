require_relative 'spec_helper'
require 'date'

describe "Hotel" do

  before do
    @rooms = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    @hotel = BookingSystem::Hotel.new
  end

  describe "#initialize" do
    it "should create an instance of Hotel" do
      @hotel.must_be_instance_of BookingSystem::Hotel

      @hotel.rooms.must_be_kind_of Array
      @hotel.must_respond_to :rooms
      @hotel.rooms.length.must_equal 20

      @hotel.reservations.must_be_kind_of Array
      @hotel.must_respond_to :reservations
      @hotel.reservations.must_be_empty
    end
  end # Describe

  describe "#create_reservation(assigned_room, check_in, check_out)" do
    # TODO: Must write a regex to check input format from the user
    xit "check_in and check_out must be inputted as a specific format" do
    end

    it "check_in must be before the check_out date" do
      check_in = '2001-02-03'
      check_out = '2001-02-04'
      @hotel.create_reservation(check_in, check_out)
    end

    it "should add only one Reservation at a time to @reservations array" do
      check_in = '2001-02-03'
      check_out = '2001-02-04'
      @hotel.create_reservation(check_in, check_out)
      @hotel.reservations.must_be_kind_of Array
      @hotel.reservations.length.must_equal 1
    end

    it "should return one instance of BookingSystem::Reservation" do
      check_in = '2001-02-03'
      check_out = '2001-02-04'
      @hotel.create_reservation(check_in, check_out)
      @hotel.reservations[0].must_be_instance_of BookingSystem::Reservation
      @hotel.reservations.length.must_equal 1
    end

    it "should return all instances of BookingSystem::Reservations" do
      check_in = '2001-02-03'
      check_out = '2001-02-04'
      100.times do
        @hotel.create_reservation(check_in, check_out)
      end
      @hotel.reservations.each do |reservation|
        reservation.must_be_instance_of BookingSystem::Reservation
      end
      @hotel.reservations.length.must_equal 100
    end
  end # Describe

  describe "#reserve_block" do
    it "should create one instance of BookingSystem::Block" do
      @hotel.reserve_block("Bob", '2001-02-03', '2001-02-05', 5).must_be_instance_of BookingSystem::Block
    end

    it "should add BookingSystem::Block instance to all @reservations by one" do
      @hotel.reserve_block("Bob", '2001-02-03', '2001-02-05', 5)
      @hotel.reservations[0].must_be_instance_of BookingSystem::Block
      @hotel.reservations.length.must_equal 1
    end

    #TODO: Write extra tests for this block
  end

  describe "#all_reservations(date)" do
    it "should return an array of all Reservations instances with the requested date" do
      @hotel.create_reservation('2001-02-03', '2001-02-05')
      @hotel.create_reservation('2001-02-01', '2001-02-03')
      # @hotel.create_reservation(3, '2001-02-05', '2001-02-07')
      # @reservations is now filled with Reservation objects
      current_reservations = @hotel.all_reservations_on('2001-02-03')
      current_reservations.length.must_equal 1
      current_reservations.must_be_kind_of Array
    end
  end # Describe

  describe "#check_avail_rooms_for" do
    it "should return room numbers available as an Array of Integers" do
      @hotel.create_reservation('2001-02-03', '2001-02-05')
      # @reservations array is full!
      check_in = '2001-02-03'
      check_out = '2001-02-05'
      @hotel.check_avail_rooms_for(check_in, check_out).must_be_kind_of Array
      @hotel.check_avail_rooms_for(check_in, check_out).each do |room|
        room.must_be_kind_of Integer
        end
      @hotel.check_avail_rooms_for(check_in, check_out).must_equal [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    end

    it "should return default room numbers if no rooms are booked for requested date range" do
      @hotel.create_reservation('2001-02-01', '2001-02-02')
      # @reservations array is full!
      check_in = '2001-02-03'
      check_out = '2001-02-05'
      @hotel.check_avail_rooms_for(check_in, check_out).must_be_kind_of Array
      @hotel.check_avail_rooms_for(check_in, check_out).each do |room|
        room.must_be_kind_of Integer
        end
      @hotel.check_avail_rooms_for(check_in, check_out).must_equal [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    end
  end # Describe

end # Describe
