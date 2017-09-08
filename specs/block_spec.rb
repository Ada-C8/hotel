require_relative 'spec_helper'

describe "Block class" do

  before do
    number_of_rooms = 2
    all_room_numbers = [1, 2]
    check_in = Date.new(2017,9,9)
    check_out = Date.new(2017,9,12)
    @test_ob = BookingSystem::Block.new(number_of_rooms, all_room_numbers, check_in, check_out)
  end

  describe "initialize method" do

    it "Can be called" do
      @test_ob.must_be_instance_of BookingSystem::Block
    end

    it "Has an instance variable @number_of_rooms that is an Integer" do
      @test_ob.number_of_rooms.must_be_instance_of Integer
    end

    it "Raises an ArgumentError if not passed an Integer for number_of_rooms" do
      proc { BookingSystem::Block.new("five", Date.new(2017,9,9), Date.new(2017,9,12)) }.must_raise ArgumentError

      proc { BookingSystem::Block.new(0, Date.new(2017,9,9), Date.new(2017,9,12)) }.must_raise ArgumentError
    end

    it "Has an instance variable @date_range that is an Array" do
      @test_ob.date_range.must_be_instance_of Array
    end

    it "Has a ROOM_PRICE constant set to 200" do
      BookingSystem::Block::ROOM_PRICE.must_equal 200
    end

    it "Has a DISCOUNTED_PRICE constant set to the ROOM_PRICE minus 15%" do
      room_price = 200
      discounted_price = room_price - (room_price * 0.15)
      BookingSystem::Block::DISCOUNTED_PRICE.must_equal discounted_price
    end

  end

  

  describe "block_total_cost" do

    it "Can be called" do
      @test_ob.must_respond_to :block_total_cost
    end

    it "Returns an Integer" do
      @test_ob.block_total_cost.must_be_instance_of Float
    end
  end

end
