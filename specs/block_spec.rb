require_relative 'spec_helper'

describe "Testing Block class" do

  let(:rooms) { (1..5).to_a.map { |num| Hotel::Room.new(num) } }
  let(:today) { Date.today }
  let(:two_days_later) { Date.today + 2 }
  let(:block) { Hotel::Block.new(Date.today, Date.today + 2, 0.8, rooms)}
  let(:room_to_reserve) { rooms[0] }

  describe "#initialize" do

    it "Creates a Block with a check_in and check_out date, an array of rooms, and a discounted rate" do
      room1 = block.room_block[0]

      block.must_be_instance_of Hotel::Block
      block.check_in.must_equal today
      block.check_out.must_equal two_days_later
      block.room_block.must_equal rooms
      (block.discount * room1.rate).must_be :<, room1.rate
    end

    it "Creates a block id based that auto-increments based on length of @@all_blocks" do
      Hotel::Block.clear

      block1 = Hotel::Block.new(today, two_days_later, 0.8, rooms)
      block1.block_id.must_equal 1

      block2 = Hotel::Block.new(two_days_later, two_days_later + 1, 0.8, rooms)
      block2.block_id.must_equal 2
    end

    it "Creates a block with no more than MAX_ROOMS num of rooms" do
      rooms << Hotel::Room.new(6)

      proc {Hotel::Block.new(today, two_days_later, 0.8, rooms) }.must_raise ArgumentError
    end

    it "Raises an error if it tries to include an unavailable room for the given dates in the block" do
      unavail_room = rooms[0]
      unavail_room.reserve(today, two_days_later)

      proc { Hotel::Block.new(today, two_days_later, 0.8, rooms) }.must_raise ArgumentError
    end

    it "Adds itself to each room's list of blocks" do
      block1 = Hotel::Block.new(today, two_days_later, 0.8, rooms)

      rooms.each do |room|
        room.blocks.length.must_equal 1
        room.blocks.must_include block1
      end

      block2 = Hotel::Block.new(two_days_later, two_days_later + 3, 0.8, rooms)

      rooms.each do |room|
        room.blocks.length.must_equal 2
        room.blocks.must_include block2
      end

    end
  end

  describe "#self.clear" do
    it "Clears all Block instances from the @@all_blocks array" do
      Hotel::Block.clear
      Hotel::Block.all.must_equal []

      new_block = Hotel::Block.new(today, two_days_later, 0.8, rooms)
      Hotel::Block.all.must_equal [new_block]

      Hotel::Block.clear
      Hotel::Block.all.must_equal []

    end
  end

  describe "#self.all" do
    it "Returns an array of all Block instances" do
      Hotel::Block.clear

      block1 = Hotel::Block.new(today, two_days_later, 0.8, rooms)
      Hotel::Block.all.must_equal [block1]

      block2 = Hotel::Block.new(two_days_later, two_days_later + 1, 0.8, rooms)
      Hotel::Block.all.must_equal [block1, block2]
    end
  end

  describe "#self.find" do

    before do
      Hotel::Block.clear

      @block_to_find = Hotel::Block.new(today, two_days_later, 0.8, rooms)
      Hotel::Block.new(two_days_later, two_days_later + 1, 0.8, rooms)
    end

    it "Returns a block matching the given block_id" do
      Hotel::Block.find(1).must_equal @block_to_find
    end

    it "Returns nil if no such block found" do
      Hotel::Block.find(5).must_be_nil
    end
  end

  describe "#is_available" do

    it "Returns true if a room in the block is available" do
      block.room_available?(room_to_reserve).must_equal true

      room_to_reserve.reserve(today, two_days_later)
      block.room_available?(room_to_reserve).must_equal false
    end

    it "Raises an argument error if room isn't in the block" do
      wrong_room = Hotel::Room.new(6)
      proc { block.room_available?(wrong_room) }.must_raise ArgumentError
    end
  end

  describe "#find_avail_in_block" do

    it "Returns a list of rooms that are available in the block" do
      block.find_avail_in_block.must_equal rooms

      rooms[0].reserve(today, two_days_later)
      rooms[1].reserve(today, two_days_later)

      block.find_avail_in_block.must_equal rooms[2..-1]
    end

    it "Returns an empty array if no rooms available" do
      block.find_avail_in_block.must_equal rooms

      5.times do |num|
        rooms[num].reserve(today, two_days_later)
      end

      block.find_avail_in_block.must_equal []
    end
  end

  describe "#reserve" do

    it "Reserves a room for the dates of the block" do
      block_res = block.reserve(room_to_reserve)

      block_res.check_in.must_equal today
      block_res.check_out.must_equal two_days_later
    end

    it "Raises an error if it tries to reserve a room not in the block" do
      room_outside_block = Hotel::Room.new(20)
      proc { block.reserve(room_outside_block) }.must_raise ArgumentError
    end

    it "Raises an error if it tries to reserve an room that's already reserved" do
      block.reserve(room_to_reserve)
      proc {block.reserve(room_to_reserve) }.must_raise ArgumentError
    end
  end

  xdescribe "#discounted_cost" do
    it "Returns the total cost of reserving a room in a block" do
      expected_cost = (room_to_reserve.rate * 0.8) * (check_out - check_in).to_i
      block.discounted_cost(room_to_reserve).must_equal expected_cost

      room_to_reserve.rate = 300
      updated_expected_cost = (room_to_reserve.rate * 0.8) * (check_out - check_in).to_i
      block.discounted_cost(room_to_reserve).must_equal updated_expected_cost

    end
  end

end
