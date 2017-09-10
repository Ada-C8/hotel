require_relative 'spec_helper'

require 'date'

describe "Hotel" do
  let(:hotel) { Hotel::Hotel.new }
  let(:smith) { hotel.new_reservation("smith", "10-01-2017", "10-04-2017", 2) }
  let(:garcia) { hotel.new_reservation("garcia", "10-02-2017", "10-06-2017", 4) }
  let(:jones) { hotel.new_reservation("jones", "10-02-2017", "10-04-2017", 5) }

  describe "initialize" do
    it "creates a Hotel instance" do
      hotel.must_be_instance_of Hotel::Hotel
      hotel.must_respond_to :rooms
    end

    it "provides a list of all reservations" do
      hotel.reservations.must_be_instance_of Array
      hotel.reservations.length.must_equal 0
    end

    it "provides a list of all rooms" do
      hotel.rooms.must_be_instance_of Array
      hotel.rooms.length.must_equal 20
      hotel.rooms[18].number.must_equal 19
    end
  end


  describe "new_reservation" do
    before do
      smith
      garcia
      jones
    end

    it "returns an Array of Reservation objects" do
      hotel.reservations.each { |reserv| reserv.must_be_instance_of Hotel::Reservation }
      hotel.reservations[0].checkin.must_equal Date.new(2017, 10, 1)
    end

    it "raises an ArgumentError when a room is not available for a given range" do
      proc { hotel.new_reservation("blanco", "10-02-2017", "10-04-2017", 5) }.must_raise ArgumentError
    end

    it "allows reservation starting on checkout date" do
      before = hotel.reservations.length
      hotel.new_reservation("blanco", "10-04-2017", "10-07-2017", 5)

      hotel.reservations.length.must_equal (before + 1)
    end
  end

  describe "reservations_on" do
    it "provides a list of all reservations on a given date" do
      smith
      garcia
      jones

      hotel.reservations_on("10-02-2017").must_be_instance_of Array
      hotel.reservations_on("10-02-2017").length.must_equal 3

      hotel.reservations_on("10-05-2017").length.must_equal 1
    end
  end

  describe "rooms_available" do
    it "provides a list of available rooms for a date range" do
      smith
      garcia
      jones

      open_rooms = hotel.rooms_available("10-01-2017", "10-05-2017")

      open_rooms.must_be_instance_of Array
      open_rooms.length.must_equal 17
    end
  end

  describe "new_block" do
    let(:block) { hotel.new_block("hernandez", "10-01-2017", "10-04-2017", 4, "10") }

    it "can create a block of rooms, with date range, discount rate, and number of rooms" do
      block

      hotel.blocks.length.must_equal 1
      hotel.blocks[0].room.must_be_instance_of Array
      hotel.blocks[0].must_respond_to :discount
    end

    it "only blocks rooms that are available" do
      smith
      garcia
      jones
      block

      hotel.blocks[0].room.wont_include 2
      hotel.blocks[0].room.wont_include 4
      hotel.blocks[0].room.wont_include 5
    end

    it "prevents its rooms from showing as available" do
      block
      open_rooms = hotel.rooms_available("10-01-2017", "10-05-2017")

      open_rooms.length.must_equal 16
    end

    it "contains a maximum of 5 rooms" do
      proc { hotel.new_block("lopez", "10-01-2017", "10-04-2017", 10, "10") }.must_raise ArgumentError
    end
  end

  describe "reserve_from_block" do
    let(:hernandez) { hotel.new_block("hernandez", "10-01-2017", "10-04-2017", 4, "10") }

    it "removes a room from a block" do
      hernandez
      hotel.blocks[0].room.length.must_equal 4

      hotel.reserve_from_block("hernandez", 3, "fish")
      hotel.blocks[0].room.length.must_equal 3
    end

    it "adds a blocked room to reservations" do
      hernandez
      hotel.reservations.length.must_equal 0
      hotel.reserve_from_block("hernandez", 3, "puente")
      hotel.reservations.length.must_equal 1
    end
  end

  describe "block_rooms_avail" do
    let(:hernandez) { hotel.new_block("hernandez", "10-01-2017", "10-04-2017", 4, "10") }

    it "finds a block given the name it was reserved under" do
      hernandez
      hotel.block_rooms_avail("hernandez").must_equal [1, 2, 3, 4]

      hotel.reserve_from_block("hernandez", 3, "puente")
      hotel.block_rooms_avail("hernandez").must_equal [1, 2, 4]
    end
  end
end
