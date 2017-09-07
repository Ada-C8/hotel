require_relative 'spec_helper'

describe Hotel::Block do
  describe "a block instance can be created" do
    it "initializes with a number of rooms and a name" do
      Hotel::Block.new(Date.new(2018, 5, 12), Date.new(2018, 5, 18),[Hotel::Room.new(5)], "guest")
    end

    it "raises an ArgumentError if less than 1 or more than 5 rooms are passed" do
      rooms = []

      (1..6).each do |num|
        rooms << Hotel::Room.new(num)
      end

      proc{Hotel::Block.new(Date.new(2018, 5, 12), Date.new(2018, 5, 18),[], "guest")}.must_raise ArgumentError

      proc{Hotel::Block.new(Date.new(2018, 5, 12), Date.new(2018, 5, 18), rooms, "guest")}.must_raise ArgumentError
    end

    it "raises an ArgumentError if the variable rooms that is passed in is not an Array of Rooms" do
      rooms = []

      (1..4).each do |num|
        rooms << Hotel::Room.new(num)
      end

      block = Hotel::Block.new(Date.new(2018, 5, 12), Date.new(2018, 5, 18),rooms, "guest")

      block.rooms_in_block.must_be_kind_of Array
      block.rooms_in_block.each do |room|
        room.must_be_instance_of Hotel::Room
      end

    end

  end





end
