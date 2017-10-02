require 'date'
require_relative 'spec_helper'

describe "HotelBooking::Room class" do
  describe "initialize" do
    it "requires one argument, number" do
      proc {HotelBooking::Room.new}.must_raise ArgumentError

      new_room = HotelBooking::Room.new(1)
      new_room.must_be_instance_of HotelBooking::Room
    end

    it "creates a new Room object with the correct id, and initialized with the correct default values for status and nightly_rate" do
      new_room = HotelBooking::Room.new(1)

      new_room.id.must_equal 1
      new_room.nightly_rate.must_equal 200
    end

    it "can take an optional argument nightly_rate if we want to give it a different nightly_rate" do
      vip_room = HotelBooking::Room.new(100, 350)

      vip_room.id.must_equal 100
      vip_room.nightly_rate.must_equal 350
    end

  end #end initialize

  describe "reserve_room" do
    it "can reserve a room if given the check-in/out date, reservation id, and guest id" do
      room = HotelBooking::Room.new(666)
      check_in= Date.parse("2018-08-09")
      check_out = Date.parse("2018-08-12")

      room.reserve_room(check_in, check_out, 1, 13)

      (check_in...check_out).each do |date|
        room.all_dates.must_include date
      end

      check_in2 = Date.parse("2018-09-28")
      check_out2= Date.parse("2018-10-1")

      room.reserve_room(check_in2, check_out2, 8, 23)
      (check_in2...check_out2).each do |date|
        room.all_dates.must_include date
      end
    end

  end #end reserve_room


  describe "available_all_days?" do
    it "returns the correct Boolean value" do
      new_hotel = HotelBooking::Hotel.new
      room1 = new_hotel.all_rooms[0]

      check_in = Date.parse("2018-03-14")
      check_out = Date.parse("2018-03-18")

      room1.available_all_days?(check_in, check_out).must_equal true
      room1.available_all_days?(check_in, check_out).must_be_instance_of TrueClass

      room1.reserve_room(check_in, check_out, 1, 2)

      check_in2 = Date.parse("2018-03-16")
      check_out2= Date.parse("2018-03-17")

      room1.available_all_days?(check_in2, check_out2).must_equal false
      room1.available_all_days?(check_in2, check_out2).must_be_instance_of FalseClass

      #### can make reservations that check-in on the same day that somebody checks out
      check_in3 = Date.parse("2018-03-18")
      check_out3 = Date.parse("2018-03-21")

      room1.available_all_days?(check_in3, check_out3).must_equal true
      room1.available_all_days?(check_in3, check_out3).must_be_instance_of TrueClass
    end

  end #end available_all_days

  describe "block room" do
    it "can block a room if given the check-in/out date and block id so that it is unavailable to reserve via regular reservations" do
      room = HotelBooking::Room.new(666)
      check_in = Date.parse("2018-08-09")
      check_out = Date.parse("2018-08-12")
      block_id = 3

      room.block_room(check_in, check_out, block_id)

      (check_in...check_out).each do |date|
        room.all_dates.must_include date
      end

      check_in2 = Date.parse("2018-09-28")
      check_out2 = Date.parse("2018-10-1")

      room.reserve_room(check_in2, check_out2, 8, 23)
      (check_in2...check_out2).each do |date|
        room.all_dates.must_include date
      end
    end
  end


  describe "self.setup_rooms" do
    it "returns an array of all room objects, with the accurate number of rooms" do
      test_all_rooms = HotelBooking::Hotel.setup_rooms

      test_all_rooms.must_be_instance_of Array

      test_all_rooms.each do |room|
        room.must_be_instance_of HotelBooking::Room
        room.nightly_rate.must_equal 200
      end

      test_all_rooms.count.must_equal 20
    end
  end #end self.setup_rooms

end #end HotelBooking::Room class tests
