require_relative 'spec_helper'

require 'date'

describe "Hotel" do
  let(:hotel) { Hotel::Hotel.new }
  let(:smith) { hotel.new_reservation("10-01-2017", "10-04-2017", 2) }
  let(:garcia) { hotel.new_reservation("10-02-2017", "10-06-2017", 4) }
  let(:jones) { hotel.new_reservation("10-02-2017", "10-04-2017", 5) }

  describe "initialize" do
    it "creates a Hotel instance" do
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
      proc { hotel.new_reservation("10-02-2017", "10-04-2017", 5) }.must_raise ArgumentError
    end

    it "allows reservation starting on checkout date" do
      before = hotel.reservations.length
      hotel.new_reservation("10-04-2017", "10-07-2017", 5)

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
    it "can create a block of rooms, with date range, discount rate, and room numbers" do
      block = hotel.new_block("10-01-2017", "10-04-2017", 4, "10")
      hotel.blocks.length.must_equal 1
      # block.must_respond_to :checkin
      # block.must_respond_to :checkout
      # block.must_respond_to :discount
      # block.must_respond_to :rooms
    end

    xit "only accepts rooms that are available" do

    end

    xit "prevents its rooms from showing as available" do

    end

    xit "contains a maximum of 5 rooms" do

    end
  end

  xdescribe "reserve_from_block" do
    it "reserves a room from a block" do

    end

    it "will have the same reservation dates as the block" do

    end
  end
end
