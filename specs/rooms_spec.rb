require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/rooms'
require_relative './spec_helper.rb'

describe "Rooms wave 1" do
  describe "initialize rooms" do

  it "can initialize rooms" do
    new_rooms = Hotel::Rooms.new(1)
    new_rooms.must_be_instance_of Hotel::Rooms
    new_rooms.number.must_be_kind_of Integer
  end

  describe "Rooms.all" do

    it "can return an array of all rooms" do
    all_rooms = Hotel::Rooms.all
    all_rooms.must_be_instance_of Array
    all_rooms[0].number.must_equal 1
    all_rooms[19].number.must_equal 20
    all_rooms.each do |room|
      room.must_be_instance_of Hotel::Rooms
    end
      all_rooms.length.must_equal 20
    end

  describe "Rooms.find" do

    it "can find an instance of room" do
      Hotel::Rooms.find(1).must_be_instance_of Hotel::Rooms
      Hotel::Rooms.find(20).must_be_instance_of Hotel::Rooms
    end
    it "throws argument error for invalid room number" do
      proc {Hotel::Rooms.find(0)}.must_raise ArgumentError
      proc {Hotel::Rooms.find(21)}.must_raise ArgumentError
    end
  end


  end


end
end
