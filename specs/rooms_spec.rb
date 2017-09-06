require_relative './spec_helper'
require_relative '../lib/rooms'

describe "#rooms" do
  before do
    @my_room = Room.new(21, 200)
    @my_room.add_reservation("January 4, 2018", "January 10, 2018")
  end
  describe "#methods" do
    it "A new room can be created" do
      @my_room.must_be_instance_of Room
      @my_room.rate.must_equal 200
      @my_room.number.must_equal 21
    end


    xit "An admin can reserve a room in a given date range" do


    end

    it "Can display a list of rooms reserved on a specific date" do

    end

    it "Can show a list of reservations for a given room" do
      @my_room.reservations.length.must_equal 1
      @my_room.reservations.must_be_instance_of Array
      @my_room.reservations.first.must_be_instance_of Reservation
      @my_room.reservations.first.num_nights.must_equal 6
      # @my_room.reservations.first.
    end
  end
end
