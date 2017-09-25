require_relative 'spec_helper'

describe "Block class" do
  before do
    number_of_rooms = 2
    rooms_in_block = [1, 2]
    check_in = Date.new(2017,9,9)
    check_out = Date.new(2017,9,12)
    @test_ob = BookingSystem::Block.new( number_of_rooms, rooms_in_block, check_in, check_out)
  end

  it "Has a class variable @@block_count that is an Integer" do
    BookingSystem::Block.block_count.must_be_instance_of Integer
  end

  describe "initialize method" do
    it "Can be called" do
      @test_ob.must_be_instance_of BookingSystem::Block
    end

    it "Inherits from DateRange class" do
      @test_ob.must_be_kind_of BookingSystem::DateRange
    end

    it "Has a class variable @@block_count that increments by 1 with each new instance of Block" do
      block_count_test_ob = BookingSystem::Block.block_count

      number_of_rooms = 3
      rooms_in_block = [3, 4, 5]
      check_in = Date.new(2017,9,12)
      check_out = Date.new(2017,9,15)
      @test_ob_2 = BookingSystem::Block.new( number_of_rooms, rooms_in_block, check_in, check_out)

      BookingSystem::Block.block_count.must_equal (block_count_test_ob + 1)
    end


    it "Has an instance variable @block_id that is an Integer and is equal to @@block_count" do
      @test_ob.block_id.must_be_instance_of Integer

      @test_ob.block_id.must_equal BookingSystem::Block.block_count
    end

    it "Has an instance variable @number_of_rooms that is an Integer" do
      @test_ob.number_of_rooms.must_be_instance_of Integer
    end

    it "Has an instance variable @rooms_in_block that shows all the rooms in this block as an Array" do
      @test_ob.rooms_in_block.must_be_instance_of Array
    end

    it "Has an instance variable @rooms_available that shows the rooms that are available in block in an Array" do
      @test_ob.rooms_available.must_be_instance_of Array
    end

  end

  describe "remove_reserved_room_from_availability method" do
    it "Can be called" do
      @test_ob.must_respond_to :remove_reserved_room_from_availability
    end

    it "Returns an Array" do
      @test_ob.remove_reserved_room_from_availability(1).must_be_instance_of Array
    end

    it "Takes a room out of availablity when a Reservation is made" do
      @test_ob.remove_reserved_room_from_availability(2)
      @test_ob.rooms_available.length.must_equal 1
    end
  end

end
