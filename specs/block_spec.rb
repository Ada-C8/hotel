require_relative 'spec_helper'

describe "Block child class" do

  describe "initialization" do
    before do
      @block = Hotel::BlockRoom.new('sept 1 2017', 'sept 2 2017', 3, "Fernandez", 10)
    end

    it "Can create an instance of block" do
      @block.must_be_instance_of Hotel::BlockRoom
    end

    it "Can call methods regarding instance methods created" do
      @block.reservation_array.must_be_instance_of Array
      @block.num_of_rooms.must_equal 3
      @block.discount.must_equal 10
      @block.check_in.must_be_instance_of Date
      @block.check_out.must_be_instance_of Date
      @block.block_of_rooms.must_be_instance_of Array
      @block.cost.must_equal 200
      @block.booked_rooms.must_be_instance_of Array
      @block.available_rooms.must_be_instance_of Array
    end

  end

  describe "check if block has rooms available" do
    before do
      @block = Hotel::BlockRoom.new('sept 1 2017', 'sept 2 2017', 3, "Fernandez", 10)
    end

    it "Can raise an argument if there aren't rooms available" do
      @block.available_rooms = []
      proc {@block.check_if_block_has_available_rooms}.must_raise ArgumentError
    end

    it "Can return an array of available rooms" do
      @block.available_rooms = [2,3,4]
      @block.check_if_block_has_available_rooms.must_equal true
    end
  end

end #block describe
