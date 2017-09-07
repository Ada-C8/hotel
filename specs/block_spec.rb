require_relative 'spec_helper'

describe "Testing Block class" do
  describe "#initialize" do
    before do
      @rooms = []
      4.times do |num|
        @rooms << Hotel::Room.new(num + 1)
      end

      @check_in = Date.new(2017,9,3)
      @check_out = Date.new(2017,9,5)

      @block = Hotel::Block.new(@check_in, @check_out, 0.2, @rooms)
    end

    it "Creates a Block with a check_in and check_out date, an array of rooms, and a discounted rate" do
      room1 = @block.room_block[0]

      @block.must_be_instance_of Hotel::Block
      @block.check_in.must_equal @check_in
      @block.check_out.must_equal @check_out
      @block.room_block.must_equal @rooms
      (@block.discount * room1.rate).must_be :<, room1.rate
    end

    it "Creates a block with no more than MAX_ROOMS num of rooms" do
      @rooms << Hotel::Room.new(5)
      @rooms << Hotel::Room.new(6)

      proc {Hotel::Block.new(@check_in, @check_out, 0.2, @rooms) }.must_raise ArgumentError
    end
  end
end
