require_relative 'spec_helper'
require 'pry'

describe "BlockReservation" do
  before do
    @admin = Hotel::Admin.new()
    date1 = Date.new(2017, 8, 10)
    date2 = Date.new(2017, 8, 15)
    # rooms aren't reserved yet
    rooms = [@admin.rooms[0], @admin.rooms[1], @admin.rooms[2]]
    @block_reservation = Hotel::BlockReservation.new(date1, date2, rooms)
  end

  describe "initialize" do
    it "Can create an object of class BlockReservation" do
        @block_reservation.must_be_instance_of Hotel::BlockReservation
        @block_reservation.reservations.must_be_instance_of Array
        @block_reservation.rooms[0].must_be_instance_of Hotel::Room
        @block_reservation.rooms.length.must_equal 3
        @block_reservation.check_in.must_be_instance_of Date
        @block_reservation.check_out.must_be_instance_of Date
        @block_reservation.rate.must_be_instance_of Float
        @block_reservation.rate.must_equal 0.15
    end

    it "Can't create a block more than 5 rooms" do
      rooms = [@admin.rooms[3], @admin.rooms[4], @admin.rooms[5], @admin.rooms[6], @admin.rooms[7], @admin.rooms[8]]
      proc {@admin.create_block(Date.new(2017, 1, 1), Date.new(2017, 1, 5), rooms)}.must_raise ArgumentError
    end
  end

  describe "total_cost" do
    it "Can return the total cost of reserved rooms in the block with the rate applied" do
      #initialized block has...
      # Rooms 1-3,Base Cost: 3000 (5 days * $600 for room), apply 15% off
      @block_reservation.make_reservation(1)
      @block_reservation.make_reservation(2)
      @block_reservation.make_reservation(3)
      @block_reservation.total_cost.must_equal 2550
    end
  end

  describe "rooms_available_in_block" do
    before do
      date1 = Date.new(2017, 8, 10)
      date2 = Date.new(2017, 8, 15)
      rooms = [@admin.rooms[0], @admin.rooms[1], @admin.rooms[2]]#room 1
      @block_reservation2 = Hotel::BlockReservation.new(date1, date2, rooms)
    end

    it "Returns an array of Rooms available inside a block" do
      # binding.pry
      @block_reservation2.rooms_available.must_be_instance_of Array
      @block_reservation2.rooms_available.length.must_equal 3
      @block_reservation2.rooms_available.each do |room|
        (1..19).include?(room.room_number).must_equal true
      end
    end

  end

end
