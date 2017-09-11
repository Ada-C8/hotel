require_relative 'spec_helper'
require_relative '../lib/hotel'

describe 'Hotel' do

  before do
    @test_hotel = Property::Hotel.new
  end

  it "can be initialized" do
    @test_hotel.must_be_instance_of Property::Hotel
  end
  it "responds to its attr_reader" do
    @test_hotel.must_respond_to :reservations
    @test_hotel.must_respond_to :rooms
    @test_hotel.must_respond_to :room_price
  end

  it "can access the list of all of the rooms in the hotel" do
    @test_hotel.rooms.must_equal (1..20).to_a
  end

  it "there should be 20 total rooms" do
    @test_hotel.rooms.count.must_equal 20
  end

  it "room always costs $200/night" do
    @test_hotel.room_price.must_equal 200
  end
end

describe "reserve_room" do

  before do
    @test_hotel = Property::Hotel.new
    @check_in = Date.new(2017, 05, 05)
    @check_out = @check_in + 3
  end


  it "cannot book invalid room number" do
    room = "garbage"
    proc {@test_hotel.reserve_room(room, @check_in, @check_out)}.must_raise ArgumentError
  end

  it "raises an error if tried to double-book room " do
    room = 5
    @test_hotel.reserve_room(room, @check_in, @check_out)
    proc {@test_hotel.reserve_room(room, @check_in, @check_out)}.must_raise ArgumentError
  end

  it "adds the reservation to @reservations" do
    test_rez = @test_hotel.reserve_room(10, @check_in, @check_out)
    @test_hotel.reservations.must_include test_rez
  end

  it "can access the list of reservations for a specific date" do
    rez = @test_hotel.reserve_room(15, @check_in, @check_out)
    @test_hotel.reservations.must_include rez
  end

  it "I can get the total cost for a given reservation" do
    rez = @test_hotel.reserve_room(20, @check_in, @check_out)
    rez.total_price.must_equal 600
  end

  it "I can view a list of rooms that are not reserved for a given date range" do
    @test_hotel.reserve_room(3, @check_in, @check_out)
    @test_hotel.available(@check_in, @check_out).include?(3).must_equal false
  end

  it "can book a room that is available" do
    excluding_one_room = @test_hotel.reserve_room(2, @check_in, @check_out)
    available_room = @test_hotel.available(@check_in, @check_out).first
    booking_available_room = @test_hotel.reserve_room(available_room, @check_in, @check_out)
    @test_hotel.reservations.must_include booking_available_room
    @test_hotel.reservations.length.must_equal 2
  end
end

describe "block functionality" do
  before do
    @test_hotel = Property::Hotel.new
    @room_qty = 3
    @check_in = Date.new(2017, 5, 5)
    @check_out = @check_in + 3
    @price = 150
    # @block = @test_hotel.hotel_block(@room_qty, @check_in, @check_out, @price)
  end

  it "cannot book zero rooms " do
    proc {@test_hotel.hotel_block(0, @check_in, @check_out, @price)}.must_raise ArgumentError
  end
end
  # it "correct number of rooms booked in a block " do
  #   @block = @test_hotel.hotel_block(@room_qty, @check_in, @check_out, @price)
  #   @block.rooms.length.must_equal @room_qty
  # end

  # it "once block booked, reserved_blocks reflects it" do
  #   @block = @test_hotel.hotel_block(@room_qty, @check_in, @check_out, @price)
  #   @reserved_blocks.must_include @block
  # end


  # it "reservation cannot be made for room when check in and checkout dates overlap" do
  #   rez = @test_hotel.reserve_room(3, @check_in, @check_out)
  #   rez2 = @test_hotel.reserve_room(3, @check_out, (@check_out+ 3))
  #   @test_hotel.reservations.include?(rez2).must_equal false
  # end
  #this test fails. I need to strategize and decide how I'll make sure check in is
  #not available on the day of check out for the same room.
  #one way I am thinking of doing this is to set time, but that just introduces more
  #complexity ...
