require_relative 'spec_helper'

describe "Block class" do
  before do
    Availability.create_calendar
  end

  describe "initialize new block" do
    it "returns an error if you try and book a block less than 2 rooms or more than 5 rooms" do
      proc { Block.new(1, 2017, 9, 28, 2017, 9, 29, "Smith")}.must_raise ArgumentError
      proc { Block.new(9, 2017, 9, 28, 2017, 9, 29, "Jones")}.must_raise ArgumentError
    end

    it "creates a new instance of block class" do
      block = Block.new(4, 2017, 9, 28, 2017, 9, 29, "Johnson")
      block.must_be_instance_of Block
    end

    it "returns a block id for administrator reference" do
      block = Block.new(4, 2017, 9, 28, 2017, 9, 29, "Hayward")
      block.block_id.must_equal "Hayward"
    end

    it "returns an array of rooms that have been blocked" do
      block = Block.new(4, 2017, 9, 28, 2017, 9, 29, "Cooper")
      block.blocked_rooms.must_be_instance_of Array
      block.blocked_rooms.count.must_equal 4
    end

    it "has a single check-in and check-out date that applies to all rooms in the block" do
      block = Block.new(4, 2017, 9, 28, 2017, 9, 29, "Doe")
      block.checkin_date.must_be_instance_of Date
      block.checkin_date.must_equal Date.new(2017,9,28)
      block.checkout_date.must_be_instance_of Date
      block.checkout_date.must_equal Date.new(2017,9,29)
    end

    it "provides a total cost per room with a discounted rate" do
      block = Block.new(2, 2017, 9, 28, 2017, 9, 29, "Smythe")
      block.total_cost.must_equal 175
      anotherblock = Block.new(2, 2017, 9, 28, 2017, 9, 30, "Jones")
      anotherblock.total_cost.must_equal 350
    end
  end

  describe "all blocks method" do
    it "returns an array of all blocks" do
      block = Block.new(4, 2017, 9, 28, 2017, 9, 29, "Smith")
      Block.all_blocks.must_be_instance_of Array
    end

  end


  def teardown
    Availability.set_calendar([])
  end

end
