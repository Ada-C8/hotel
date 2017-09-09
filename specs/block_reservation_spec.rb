require_relative 'spec_helper'
require 'pry'

describe "BlockReservation" do
  before do
    @admin = Hotel::Admin.new()
    date1 = Date.new(2017, 8, 10)
    date2 = Date.new(2017, 8, 15)
    rooms = [@admin.rooms[0], @admin.rooms[1], @admin.rooms[2]]#room 1
    @block_reservation = Hotel::BlockReservation.new(date1, date2, rooms)
  end

  describe "initialize" do
    it "Can create an object of class BlockReservation" do
        @block_reservation.must_be_instance_of Hotel::BlockReservation
        @block_reservation.rooms.must_be_instance_of Array
        @block_reservation.rooms[0].must_be_instance_of Hotel::Room
        @block_reservation.check_in.must_be_instance_of Date
        @block_reservation.check_out.must_be_instance_of Date
        @block_reservation.rate.must_be_instance_of Float
        @block_reservation.rate.must_equal 0.15
    end
  end

  describe "total_cost" do
    it "Can return the total cost of reserved rooms in the block with the rate applied" do
      @block_reservation.total_cost.must_equal 2550
    end
  end

end
