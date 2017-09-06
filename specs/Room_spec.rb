require 'date'
require 'pry'
require_relative 'spec_helper'


describe "Hotel::Room class" do
  describe "initialize" do
    it "requires one argument, number" do
      proc {Hotel::Room.new}.must_raise ArgumentError

      new_room = Hotel::Room.new(1)
      new_room.must_be_instance_of Hotel::Room
    end

    it "creates a new Room object with the correct id, and initialized with the correct default values for status and nightly_rate" do
      new_room = Hotel::Room.new(1)

      new_room.id.must_equal 1
      new_room.nightly_rate.must_equal 200
    end

    it "can take an optional argument nightly_rate if we want to give it a different nightly_rate" do
      vip_room = Hotel::Room.new(100, 350)

      vip_room.id.must_equal 100
      vip_room.nightly_rate.must_equal 350
    end

  end #end initialize

  describe "reserve_room" do
    it "can reserve a room if given the check-in/out date, reservation id, and guest id" do
      room = Hotel::Room.new(666)
      check_in_str = "2017-08-09"
      check_out_str = "2017-08-12"

      room.reserve_room(check_in_str, check_out_str, 1, 13)

      (Date.parse(check_in_str)...Date.parse(check_out_str)).each do |date|
        room.all_dates.must_include date
      end

      room.reserve_room("2017-08-10", "2017-08-11", 42, 16).must_equal false

      check_in_str2 = "2017-09-28"
      check_out_str2 = "2017-10-1"

      room.reserve_room(check_in_str2, check_out_str2, 8, 23)
      (Date.parse(check_in_str2)...Date.parse(check_out_str2)).each do |date|
        room.all_dates.must_include date
      end

    end

    it "doesn't accept dates that are earlier than today's date" do

    end

  end #end reserve_room

  describe "self.all" do
    it "returns an array of all room objects, with the accurate number of rooms" do
      test_all_rooms = Hotel::Room.all

      test_all_rooms.must_be_instance_of Array

      test_all_rooms.each do |room|
        room.must_be_instance_of Hotel::Room
        room.nightly_rate.must_equal 200
      end

      test_all_rooms.count.must_equal 20

    end



  end #end self.all


end #end Hotel::Room class tests
