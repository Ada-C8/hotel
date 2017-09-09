require_relative 'spec_helper'

describe "Block class" do
  before do
    number_of_rooms = 2
    rooms_in_block = [1, 2]
    check_in = Date.new(2017,9,9)
    check_out = Date.new(2017,9,12)
    @test_ob = BookingSystem::Block.new( number_of_rooms, rooms_in_block, check_in, check_out)
  end

  describe "initialize method" do
    it "Can be called" do
      @test_ob.must_be_instance_of BookingSystem::Block
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

    it "Has an instance variable @date_range that is an Array" do
      @test_ob.date_range.must_be_instance_of Array
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
