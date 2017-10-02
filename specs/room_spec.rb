require_relative 'spec_helper'

describe "Room" do
  describe "initialize" do
    it "takes a room number and rate" do
      room_num = 1
      room_rate = 200
      room = Hotel::Room.new(room_num, room_rate)
      room.must_be_instance_of Hotel::Room

      room.room_num.must_equal room_num
      room.must_respond_to :room_num

      room.room_rate.must_equal 200
      room.room_rate.must_be_kind_of Integer
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
