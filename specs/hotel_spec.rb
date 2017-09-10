require_relative 'spec_helper'

describe "Hotel" do

  let(:hotel) { BookingSystem::Hotel.new }

  before do
    @name = "Bob"
    @check_in = '2001-02-03'
    @check_out = '2001-02-04'

    def create_one_res
      hotel.create_reservation(@name, @check_in, @check_out)
    end

    def create_twenty_res
      20.times do
        hotel.create_reservation(@name, @check_in, @check_out)
      end
    end

    def res_block_setup
      hotel.reserve_block(@name, @check_in, @check_out, 5)
    end
  end

  describe "#initialize" do
    it "should create an instance of Hotel" do
      hotel.must_be_instance_of BookingSystem::Hotel

      hotel.must_respond_to :rooms
      hotel.rooms.must_be_kind_of Array
      hotel.rooms.length.must_equal 20

      hotel.must_respond_to :all_reservations
      hotel.all_reservations.must_be_kind_of Array
      hotel.all_reservations.must_be_empty

      hotel.must_respond_to :block_reservations
      hotel.block_reservations.must_be_kind_of Array
      hotel.block_reservations.must_be_empty
    end
  end # Describe

  describe "#create_reservation" do
    it "should raise an ArgumentError if there are no available rooms for the same requested date" do
      create_twenty_res
      proc { create_one_res }.must_raise ArgumentError
    end

    it "should raise an ArgumentError if the name is not a String" do
      proc { hotel.create_reservation(12345, @check_in, @check_out) }.must_raise ArgumentError
    end

    it "should add only one Reservation at a time to @reservations array" do
      create_one_res

      hotel.all_reservations.must_be_kind_of Array
      hotel.all_reservations.length.must_equal 1
    end

    it "should return one instance of Reservation" do
      create_one_res

      hotel.all_reservations[0].must_be_instance_of BookingSystem::Reservation
      hotel.all_reservations.length.must_equal 1
    end

    it "should add all instances of Reservation to the @reservations instance variable" do
      create_twenty_res

      hotel.all_reservations.length.must_equal 20
      hotel.all_reservations.map { |reservation| reservation.must_be_instance_of BookingSystem::Reservation }
    end
  end # Describe


  describe "#find_reservation" do
    it "should return an instance of Reservation by name" do
      create_one_res
      found_res = hotel.find_reservation("Bob")

      found_res.must_be_instance_of BookingSystem::Reservation
      found_res.name.must_equal "Bob"
    end

    it "should raise an ArgumentError if reservation was not found" do
      create_one_res

      proc{ hotel.find_reservation("Sue") }.must_raise ArgumentError
    end
  end

  describe "#reserve_block" do
    it "should raise and ArgumentError if the number of rooms for a block is greater than 5 or less than 0" do
      proc { hotel.reserve_block(@name, @check_in, @check_out, 10) }.must_raise ArgumentError
    end

    it "should raise and ArgumentError if the number of rooms for a block is less than 1" do
      proc { hotel.reserve_block(@name, @check_in, @check_out, 0) }.must_raise ArgumentError
    end

    it "should create one instance of BookingSystem::Block" do
      res_block_setup.must_be_instance_of BookingSystem::Block
    end

    it "should add one BookingSystem::Block instance to all @reservations and @block_reservations by one" do
      res_block_setup

      hotel.all_reservations[0].must_be_instance_of BookingSystem::Block
      hotel.all_reservations.length.must_equal 1
      hotel.block_reservations.length.must_equal 1
    end

    it "should return 4 instances of block if no other single reservations exist for the same days" do
      hotel.reserve_block("Bob", '2001-02-03', '2001-02-05', 5)
      hotel.reserve_block("Pete", '2001-02-03', '2001-02-05', 5)
      hotel.reserve_block("Sally", '2001-02-03', '2001-02-05', 5)
      hotel.reserve_block("Sue", '2001-02-03', '2001-02-05', 5)

      hotel.all_reservations.map { |reservation| reservation.must_be_instance_of BookingSystem::Block }
      hotel.all_reservations.length.must_equal 4
    end

    it "should return 1 instance of Block if other single reservations already exist" do
      3.times do
        hotel.create_reservation(@name, @check_in, @check_out)
      end
      res_block_setup
      all_blocks =[]
      hotel.all_reservations.each do |reservation|
        all_blocks << reservation if reservation.class == BookingSystem::Block
      end

      all_blocks.length.must_equal 1
      all_blocks.map { |block| block.must_be_instance_of BookingSystem::Block }
    end

    it "should raise an ArgumentError if there are no available rooms for the block" do
      create_twenty_res

      proc {hotel.reserve_block("Bob", '2001-02-03', '2001-02-05', 5)}.must_raise ArgumentError
    end
  end # Describe

  describe "#find_block" do
    it "should return a single instance of a Block by name" do
      res_block_setup

      hotel.find_block("Bob").must_be_instance_of BookingSystem::Block
    end

    it "should display the price of the Block" do
      res_block_setup

      hotel.find_block("Bob").block_total.must_equal 0
    end

    it "should raise an ArgumentError if there is no match for the requested block" do
      res_block_setup

      proc { hotel.find_block("Sue") }.must_raise ArgumentError
    end
  end # Describe

  describe "#reserve_room_in_block" do
    # IN UI TEST FOR ONLY NUMBER OF AVAILABLE ROOMS
    it "should raise an ArgumentError if the number of rooms requested is greater than the number of rooms available in the block" do
      hotel.reserve_block(@name, @check_in, @check_out, 1)

      proc { hotel.reserve_room_in_block("Bob", 5) }.must_raise ArgumentError
    end

    it "should update the rooms numbers that were reserved and available withint he block" do
      res_block_setup
      hotel.reserve_room_in_block("Bob", 3)

      hotel.block_reservations[0].avail_block_rooms.must_be_kind_of Array
      hotel.block_reservations[0].avail_block_rooms.must_equal [4,5]
      hotel.block_reservations[0].reserved_rooms.must_be_kind_of Array
      hotel.block_reservations[0].reserved_rooms.must_equal [1,2,3]
    end

    it "should update the cost of the reserved rooms from within the block" do
      res_block_setup
      hotel.reserve_room_in_block("Bob", 2)

      hotel.block_reservations[0].block_total.must_equal 300
    end

    it "should raise an ArgumentError if no rooms are available within the block" do
      res_block_setup
      hotel.reserve_room_in_block("Bob", 5)

      proc { hotel.reserve_room_in_block("Bob", 5) }.must_raise ArgumentError
    end
  end # Describe

  describe "#avail_rooms_in_block" do
    it "should return an array of available room numbers for a specific block as Integers" do
      res_block_setup
      avail_rooms = hotel.avail_rooms_in_block("Bob")

      avail_rooms.must_be_kind_of Array
      avail_rooms.map { |room_num| room_num.must_be_kind_of Integer }
    end

    it "should return the first 5 available rooms as apart of the block" do
      res_block_setup

      hotel.avail_rooms_in_block("Bob").must_be_kind_of Array
      hotel.avail_rooms_in_block("Bob").length.must_equal 5
      hotel.avail_rooms_in_block("Bob").must_equal [1,2,3,4,5]
    end

    it "should return the last 5 available rooms if other blocks are booked for the same days" do
      hotel.reserve_block("Bob", '2001-02-03', '2001-02-05', 5)
      hotel.reserve_block("Pete", '2001-02-03', '2001-02-05', 5)
      hotel.reserve_block("Sally", '2001-02-03', '2001-02-05', 5)
      hotel.reserve_block("Sue", '2001-02-03', '2001-02-05', 5)

      hotel.avail_rooms_in_block("Sue").must_equal [16,17,18,19,20]
    end

    it "should raise an ArgumentError if no rooms in the block are available" do
      res_block_setup
      hotel.reserve_room_in_block("Bob", 5)
      proc { hotel.avail_rooms_in_block("Bob") }.must_raise ArgumentError
    end
  end

  describe "#all_reservations(date)" do
    it "should return an array of all Reservations instances with the requested date" do
      hotel.create_reservation("Sue", '2001-02-01', '2001-02-10')
      hotel.create_reservation("Bob", '2001-02-01', '2001-02-03')
      current_reservations = hotel.all_reservations_on('2001-02-02')

      current_reservations.length.must_equal 2
      current_reservations.must_be_kind_of Array
    end
  end # Describe

  describe "#check_avail_rooms_for" do
    it "should return room numbers available as an Array of Integers" do
      hotel.create_reservation("Bob", '2001-02-03', '2001-02-05')
      avail_rooms = hotel.check_avail_rooms_for(@check_in, @check_out)

      avail_rooms.must_be_kind_of Array
      avail_rooms.map { |room| room.must_be_kind_of Integer }
      avail_rooms.must_equal [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    end

    it "should return default room numbers if no rooms are booked for requested date range" do
      hotel.create_reservation("Bob", '2001-02-01', '2001-02-02')
      avail_rooms = hotel.check_avail_rooms_for(@check_in, @check_out)

      avail_rooms.must_be_kind_of Array
      avail_rooms.each { |room| room.must_be_kind_of Integer }
      avail_rooms.must_equal [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    end

    it "should return an ArgumentError if date range is invalid" do
      proc { hotel.check_avail_rooms_for(@check_out, @check_in) }.must_raise ArgumentError
    end
  end # Describe

end # Describe
