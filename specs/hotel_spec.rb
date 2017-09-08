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

    it "should add one BookingSystem::Block instance to all @reservations by one" do
      @hotel.reserve_block("Bob", '2001-02-03', '2001-02-05', 5)
      @hotel.reservations[0].must_be_instance_of BookingSystem::Block
      @hotel.reservations.length.must_equal 1
    end

    it "should return 4 instances of block if no other single reservations exist" do
      @hotel.reserve_block("Bob", '2001-02-03', '2001-02-05', 5)
      @hotel.reserve_block("Pete", '2001-02-03', '2001-02-05', 5)
      @hotel.reserve_block("Sally", '2001-02-03', '2001-02-05', 5)
      @hotel.reserve_block("Sue", '2001-02-03', '2001-02-05', 5)
      @hotel.reservations.length.must_equal 4
      @hotel.reservations.each do |reservation|
        reservation.must_be_instance_of BookingSystem::Block
      end
    end

    it "should return 1 instance of Block if other single reservations already exist" do
      check_in = '2001-02-03'
      check_out = '2001-02-04'
      3.times do
        @hotel.create_reservation(check_in, check_out)
      end
      @hotel.reserve_block("Bob", '2001-02-03', '2001-02-05', 5)
      all_blocks =[]
      @hotel.reservations.each do |reservation|
        if reservation.class == BookingSystem::Block
          all_blocks << reservation
        end
      end

      all_blocks.length.must_equal 1
      all_blocks.each do |block|
        block.must_be_instance_of BookingSystem::Block
      end
    end
    ####################### TODO: Raise exception here
    xit "should raise an ArgumentError if number of requested room is greater than 5 and less than 1" do
    end
  end # Describe

  xdescribe "#reserve_room_in_block" do
    it "should return integers for the available room numbers" do

    end
  end

  describe "#avail_rooms_in_block?" do
    it "should return an array of available room numbers for a specific block as Integers" do
      @hotel.reserve_block("Bob", '2001-02-03', '2001-02-05', 5)

      @hotel.avail_rooms_in_block?("Bob").must_be_kind_of Array
      @hotel.avail_rooms_in_block?("Bob").each do |room_num|
        room_num.must_be_kind_of Integer
      end
    end

    it "should return the first 5 available rooms as apart of the block" do
      @hotel.reserve_block("Bob", '2001-02-03', '2001-02-05', 5)

      @hotel.avail_rooms_in_block?("Bob").must_be_kind_of Array
      @hotel.avail_rooms_in_block?("Bob").length.must_equal 5
      @hotel.avail_rooms_in_block?("Bob").must_equal [1,2,3,4,5]
    end

    it "should return the last 5 available rooms if other blocks are booked for the same days" do
      @hotel.reserve_block("Bob", '2001-02-03', '2001-02-05', 5)
      @hotel.reserve_block("Pete", '2001-02-03', '2001-02-05', 5)
      @hotel.reserve_block("Sally", '2001-02-03', '2001-02-05', 5)
      @hotel.reserve_block("Sue", '2001-02-03', '2001-02-05', 5)

      @hotel.avail_rooms_in_block?("Sue").must_equal [16,17,18,19,20]
    end
    ################ TODO:
    xit "should return all available rooms in the block after reserve_room_in_block method was ran" do

    end

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

    #TODO: Should return an argument error if no further rooms exist!!!!!
  end # Describe

end # Describe
