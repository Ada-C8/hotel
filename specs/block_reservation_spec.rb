require_relative 'spec_helper'
require 'pry'

describe "BlockReservation" do
  before do
    @admin = Hotel::Admin.new()
    date1 = Date.new(2017, 8, 10)
    date2 = Date.new(2017, 8, 15)
    rooms = [@admin.rooms[0], @admin.rooms[1], @admin.rooms[2]]#room 1
    @reservation = Hotel::BlockReservation.new(date1, date2, rooms)
  end

  describe "initialize" do
    it "Can create an object of class BlockReservation" do
        @reservation.must_be_instance_of Hotel::BlockReservation
        @reservation.rooms.must_be_instance_of Array
        @reservation.rooms[0].must_be_instance_of Hotel::Room
        @reservation.check_in.must_be_instance_of Date
        @reservation.check_out.must_be_instance_of Date
    end
  end

end
