require_relative 'spec_helper'

describe "Room" do
  describe "initialize" do
    it "takes a room number and rate" do
      room_num = 1
      room_rate = 200
      room = Hotel::Room.new(room_num, room_rate)
      room.must_be_instance_of Hotel::Room
    end

    it "returns rooms 1, 5, 10, 13 and 20" do
    
      room_num = 1
      room_rate = 200
      room = Hotel::Room.new(room_num, room_rate)
      room.room_num.must_equal 1

      room_num = 5
      room = Hotel::Room.new(room_num, 200)
      room.room_num.must_equal 5

      room_num = 10
      room = Hotel::Room.new(room_num, 200)
      room.room_num.must_equal 10

      room_num = 13
      room = Hotel::Room.new(room_num, 200)
      room.room_num.must_equal 13

      room_num = 20
      room = Hotel::Room.new(room_num, 200)
      room.room_num.must_equal 20

    end
  end
end

# # probably can use let to trim code
#   describe "self.all" do
#     it "returns an array of all rooms" do
#       rooms = Hotel::Room.all
#       rooms.must_be_kind_of Array
#     end
#
#     it "checks the number of rooms is correct" do
#       rooms = Hotel::Room.all
#       rooms.length.must_equal 20
#     end
#
#     # it "checks the first, tenth, and twentienth rooms can be retrieved" do
#     #   rooms = Hotel::Room.all
#     #   rooms.each do |room|
#     #     room[8].must_equal 7
#     #   end
#     #   # puts rooms[0]
#     #   # rooms[0].must_equal Hotel::Room.all
#     # end
#
#     it "checks everything in the array is a room" do
#       rooms = Hotel::Room.all
#       rooms.each do |room|
#         room.must_be_instance_of Hotel::Room
#       end
#     end
#   end
