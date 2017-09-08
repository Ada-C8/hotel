require_relative 'spec_helper'

describe "Room" do
  describe "initialize" do
    it "takes a room number" do
      room_num = 1
      room = Hotel::Room.new(room_num)
      room.must_be_instance_of Hotel::Room
    end
  end

# probably can use let to trim code
  describe "self.all" do
    it "returns an array of all rooms" do
      rooms = Hotel::Room.all
      rooms.must_be_kind_of Array
    end

    it "checks the number of rooms is correct" do
      rooms = Hotel::Room.all
      rooms.length.must_equal 20
    end

    # it "checks the first, tenth, and twentienth rooms can be retrieved" do
    #   rooms = Hotel::Room.all
    #   rooms.each do |room|
    #     room[8].must_equal 7
    #   end
    #   # puts rooms[0]
    #   # rooms[0].must_equal Hotel::Room.all
    # end

    it "checks everything in the array is a room" do
      rooms = Hotel::Room.all
      rooms.each do |room|
        room.must_be_instance_of Hotel::Room
      end
    end
  end
end
