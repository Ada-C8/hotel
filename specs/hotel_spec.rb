require_relative 'spec_helper'

describe "Hotel class" do

  describe "UnavailableRoomError class" do
    it "Can be instantiated" do
      BookingSystem::Hotel::UnavailableRoomError.new.must_be_instance_of BookingSystem::Hotel::UnavailableRoomError
    end
  end

  describe "UnavailableBlockError class" do
    it "Can be instantiated" do
      BookingSystem::Hotel::UnavailableBlockError.new.must_be_instance_of BookingSystem::Hotel::UnavailableBlockError
    end
  end

  it "Has a DEFAULT_ROOM_PRICE constant that is assigned to the integer 200" do
    BookingSystem::Hotel::DEFAULT_ROOM_PRICE.must_equal 200
  end

  before do
    @test_ob = BookingSystem::Hotel.new
    @room = 1
    @check_in = Date.new(2017,9,9)
    @check_out = Date.new(2017,9,12)
  end

  describe "initialize method" do
    it "Can create a Hotel object" do
      @test_ob.must_be_instance_of BookingSystem::Hotel
    end

    it "Has an instance variable @rooms of all rooms stored as an array" do
      @test_ob.rooms.must_be_instance_of Array
    end

    it "@rooms holds Integers 1 to 20" do
      @test_ob.rooms[0].must_equal 1
      @test_ob.rooms[19].must_equal 20
    end

    it "Has an instance variable @all_single_reservations that holds objects (instances of Reservation class) in an Array" do
      @test_ob.all_single_reservations.must_be_instance_of Array

      @test_ob.make_single_reservation(@room, @check_in, @check_out)
      @test_ob.all_single_reservations[0].must_be_instance_of BookingSystem::Reservation
    end

    it "Has an instance variable @all_block_reservations that holds objects (instances of Reservation class) in an Array" do
      new_block = @test_ob.block_off_a_block(3, @check_in, @check_out)
      block_id = new_block.block_id
      @test_ob.block_reservation(block_id, 1, @check_in, @check_out)
      @test_ob.all_block_reservations[0].must_be_instance_of BookingSystem::Reservation
      @test_ob.all_block_reservations.must_be_instance_of Array
    end

    it "Has an instance variable @all_blocks that holds objects (instances of Block class) in an Array" do
      @test_ob.all_blocks.must_be_instance_of Array

      @test_ob.block_off_a_block(3, @check_in, @check_out)
      @test_ob.all_blocks[0].must_be_instance_of BookingSystem::Block
    end
  end#initialize

  describe "make_single_reservation method" do
    it "Can be called" do
      @test_ob.must_respond_to :make_single_reservation
    end

    it "Returns an instance of Reservation class when room is available" do
      @test_ob.make_single_reservation(@room, @check_in, @check_out).must_be_instance_of BookingSystem::Reservation
    end

    it "Increases @all_single_reservations by 1 for each new reservation" do
      @test_ob.make_single_reservation(@room, @check_in, @check_out)
      @test_ob.all_single_reservations.length.must_equal 1
    end

    it "Can accept a price argument" do
      @test_ob.make_single_reservation(@room, @check_in, @check_out, 100)
      @test_ob.all_single_reservations[0].price.must_equal 100
    end

    it "Will assign price to DEFAULT_ROOM_PRICE 200, if given no price argument" do
      @test_ob.make_single_reservation(@room, @check_in, @check_out)
      @test_ob.all_single_reservations[0].price.must_equal 200
    end

    it "Raises an UnavailableRoomError if room is unavailable" do
      @test_ob.make_single_reservation(@room, @check_in, @check_out)

      proc { @test_ob.make_single_reservation(@room, @check_in, @check_out) }.must_raise BookingSystem::Hotel::UnavailableRoomError

      proc { @test_ob.make_single_reservation(@room, Date.new(2017,9,5), Date.new(2017,9,10)) }.must_raise BookingSystem::Hotel::UnavailableRoomError
    end

    it "Will book two reservations with check out and check in being on the same day" do
      @test_ob.make_single_reservation(@room, @check_in, @check_out)
      @test_ob.make_single_reservation(@room, Date.new(2017,9,5), Date.new(2017,9,9))

      @test_ob.all_single_reservations.length.must_equal 2
    end
  end

  describe "block_reservation" do

    before do
      @test_ob = BookingSystem::Hotel.new
      @room = 1
      @check_in = Date.new(2017,9,9)
      @check_out = Date.new(2017,9,12)
    end

    it "Can be called" do
      @test_ob.must_respond_to :block_reservation
    end

    it "Will assign price to DEFAULT_ROOM_PRICE 200, if given no price argument" do
      new_block = @test_ob.block_off_a_block(3, @check_in, @check_out)
      block_id = new_block.block_id
      @test_ob.block_reservation(block_id, @room, @check_in, @check_out)
      @test_ob.all_block_reservations[0].price.must_equal 200
    end

    it "Can accept a price argument" do
      new_block = @test_ob.block_off_a_block(3, @check_in, @check_out)
      block_id = new_block.block_id
      @test_ob.block_reservation(block_id, @room, @check_in, @check_out, 150)
      @test_ob.all_block_reservations[0].price.must_equal 150
    end

    it "Raises UnavailableBlockError if there are no blocks available" do
      proc { @test_ob.block_reservation(1, @room, @check_in, @check_out) }.must_raise BookingSystem::Hotel::UnavailableBlockError
    end

    it "Raises UnavailableBlockError if there are no blocks that match block_id" do
      new_block = @test_ob.block_off_a_block(3, @check_in, @check_out)
      block_id = new_block.block_id
      not_block_id = block_id + 10
      proc { @test_ob.block_reservation(not_block_id, @room, @check_in, @check_out) }.must_raise BookingSystem::Hotel::UnavailableBlockError
    end

    it "Raises UnavailableRoomError if the room requested is not available" do
      new_block = @test_ob.block_off_a_block(3, @check_in, @check_out)
      block_id = new_block.block_id
      proc { @test_ob.block_reservation(block_id, 20, @check_in, @check_out) }.must_raise BookingSystem::Hotel::UnavailableRoomError
    end

    it "Adds a new block reservation to @all_block_reservations" do
      new_block = @test_ob.block_off_a_block(4, @check_in, @check_out)
      block_id = new_block.block_id
      @test_ob.block_reservation(block_id, 2, @check_in, @check_out)
      @test_ob.all_block_reservations.length.must_equal 1
    end

    it "Returns an instance of Reservation" do
      new_block = @test_ob.block_off_a_block(4, @check_in, @check_out)
      block_id = new_block.block_id
      @test_ob.block_reservation(block_id, 2, @check_in, @check_out).must_be_instance_of BookingSystem::Reservation
    end
  end

  describe "block_off_a_block method" do
    it "Can be called" do
      @test_ob.must_respond_to :block_off_a_block
    end

    it "Raises UnavailableRoomError if number of rooms requested exceeds available rooms" do
      4.times do
        @test_ob.block_off_a_block(5, @check_in, @check_out)
      end

      proc { @test_ob.block_off_a_block(3, @check_in, @check_out) }.must_raise BookingSystem::Hotel::UnavailableBlockError
    end

    it "Returns an instance of Block class" do
      @test_ob.block_off_a_block(3, @check_in, @check_out).must_be_instance_of BookingSystem::Block
    end

    it "Increases the length of the @all_blocks by 1" do
      @test_ob.block_off_a_block(3, @check_in, @check_out)
      @test_ob.all_blocks.length.must_equal 1
    end
  end

  describe "reservations_for_specific_date" do
    it "Can be called" do
      @test_ob.must_respond_to :reservations_for_specific_date
    end

    it "Returns an array of Reservation objects" do
      @test_ob.make_single_reservation(@room, @check_in, @check_out)

      @test_ob.make_single_reservation(2, Date.new(2017,9,11), Date.new(2017,9,15))
      new_block = @test_ob.block_off_a_block(4, @check_in, @check_out)
      block_id = new_block.block_id
      @test_ob.block_reservation(block_id, 3, @check_in, @check_out)

      @test_ob.reservations_for_specific_date(Date.new(2017,9,10)).must_be_instance_of Array

      @test_ob.reservations_for_specific_date(Date.new(2017,9,10))[0].must_be_instance_of BookingSystem::Reservation

      @test_ob.reservations_for_specific_date(Date.new(2017,9,11)).length.must_equal 3
    end

    it "Returns an empty array if no reservations" do
      @test_ob.reservations_for_specific_date(Date.new(2017,9,10)).must_equal []
    end

    it "Returns an empty array if no reservations match the requested date" do
      @test_ob.make_single_reservation(@room, @check_in, @check_out)

      @test_ob.make_single_reservation(2, Date.new(2017,9,11), Date.new(2017,9,15))

      @test_ob.reservations_for_specific_date(Date.new(2017,9,20)).must_equal []
    end

    it "Does not return a reservation that ends on the same date as the requested date" do
      @test_ob.make_single_reservation(@room, @check_in, @check_out)
      @test_ob.reservations_for_specific_date(Date.new(2017,9,12)).must_equal []
    end

    it "Does return a reservation that starts on the same date as the requested date" do
      @test_ob.make_single_reservation(@room, @check_in, @check_out)
      @test_ob.reservations_for_specific_date(Date.new(2017,9,9)).length.must_equal 1
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
    end

    it "Removes rooms that are reserved (single) or in a block for the given dates" do
      total_rooms = 20
      free_rooms = total_rooms - 1
      @test_ob.make_single_reservation(@room, @check_in, @check_out)
      @test_ob.available_rooms(@check_in, @check_out).length.must_equal free_rooms

      free_rooms -= 4
      @test_ob.block_off_a_block(4, @check_in, @check_out)
      @test_ob.available_rooms(@check_in, @check_out).length.must_equal free_rooms
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

      @test_ob.make_single_reservation(@room, @check_in, @check_out)

      @test_ob.send(:room_available?, @room, @check_in, @check_out).must_equal false

      @test_ob.block_off_a_block(5, block_check_in, block_check_out)

      @test_ob.send(:room_available?, 1, block_check_in, block_check_out).must_equal false
    end
  end

end
