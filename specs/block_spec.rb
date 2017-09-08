require_relative 'spec_helper'
require 'pry'

describe Hotel::Block do
  describe "a block instance can be created" do
    it "creates an instance of a block" do
      Hotel::Block.new(Date.new(2018, 5, 12), Date.new(2018, 5, 18), 111123).must_be_instance_of Hotel::Block

    end

    it "initializes with an id number between 111111 and 999999" do
      hotel = Hotel::Hotel.new
      100.times do
        check_in = rand(Date.new(2018, 1, 1)..Date.new(2019, 1, 1))
        hotel.make_block(check_in, check_in + 5, rand(1..5) )
      end

      ids = []

      hotel.blocks.each do |block|
        ids << block.id
      end

      ids.each do |id|
        id.between?(111111, 999999).must_equal true
      end

      ids.uniq!
      ids.length.must_equal 100
    end
  end

  describe "attr_readers" do
    before do
      @check_in = Date.new(2018, 1, 12)
      @check_out = Date.new(2018, 1, 14)
      @block = Hotel::Block.new(@check_in, @check_out, 111123)

      @block.add_room(Hotel::Room.new(5))
      @block.add_room(Hotel::Room.new(13))
    end

    it "can read the check_in date, check_out date, id, rooms_in_block, and the discount" do
      @block.check_in.must_equal @check_in
      @block.check_out.must_equal @check_out
      @block.id.must_equal 111123
      @block.rooms_in_block.length.must_equal 2

      @block.rooms_in_block.each do |room|
        room.must_be_instance_of Hotel::Room
      end
    end
  end

end
