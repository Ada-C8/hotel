require_relative 'spec_helper'

describe "hotel" do
  describe "ROOM_NUMBERS" do
    it "should have room numbers from 1-20" do
      Hotel::ROOM_NUMBERS.each do |num|
        (1..20).must_include num
      end
    end
    it "should have 20 hotel rooms" do
      Hotel::HOTEL_ROOMS.length.must_equal 20
    end
    it "should have 20 hotel rooms numbered 1-20" do
      Hotel::HOTEL_ROOMS.each do |room|
        (1..20).must_include room.id
      end
    end
  end

  describe "self.all_rooms" do
    it "should return an array of 20 rooms" do
      (Hotel.all_rooms).must_be_instance_of Array
      (Hotel.all_rooms).length.must_equal 20
    end
  end

  describe "self.find_room(input_id)" do
    it "should return room matching room number" do
      room_1 = Hotel.find_room(1)
      room_1.must_equal Hotel::HOTEL_ROOMS[0]
      (Hotel::HOTEL_ROOMS[0]).id.must_equal 1
      room_5 = Hotel.find_room(5)
      room_5.must_equal Hotel::HOTEL_ROOMS[4]
      (Hotel::HOTEL_ROOMS[4]).id.must_equal 5
    end
  end
end
