require_relative 'spec_helper'

describe Hotel::Room do
  describe "You can create a Room instance" do
    it "Can be created" do
      room = Hotel::Room.new(1)
      room.must_be_instance_of Hotel::Room
    end
    it "raises an ArgumentError for invalid parameters" do
      proc{Hotel::Room.new("A15")}.must_raise ArgumentError
    end
    it "initializes wiht a cost of 200 per night" do
      room = Hotel::Room.new(5)
      room.cost_per_night.must_equal 200
    end
  end

  describe "attr accessors" do
    it "can retrieve the room number using .number" do
      room = Hotel::Room.new(5)
      room.number.must_equal 5
    end
    it "can retrieve and change the cost of a room per night" do
      room = Hotel::Room.new(3)
      room.cost_per_night.must_equal 200

      room.cost_per_night = 150

      room.cost_per_night.must_equal 150
    end
  end
end
