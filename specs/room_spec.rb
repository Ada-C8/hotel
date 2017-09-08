require_relative 'spec_helper'

describe "Room" do
  describe "initialize" do
    it "takes a room number" do
      room_num = 1
      room = Hotel::Room.new(room_num)
      room.must_be_instance_of Hotel::Room
    end
  end

  describe "self.all" do
    it "returns an array of all rooms" do
      rooms = Hotel::Room.all
      rooms.must_be_kind_of Array
    end

    it "checks the number of rooms is correct" do
      rooms = Hotel::Room.all
      rooms.length.must_equal 20
    end
  end
end
