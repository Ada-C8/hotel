require_relative "spec_helper"

describe "Room class" do
  before do
    @room = Hotel::Room.new(20,200)
  end

  describe "initialize" do
    it "Creates an instance" do
      @room.must_be_kind_of Hotel::Room
    end

    it "Can access the number, cost, and reservations" do
      @room.rate.must_equal 200
      @room.room_num.must_equal 20
      @room.reservations.must_be_instance_of Array
    end
  end

  describe "create_reservation method" do
    it "Creates reservation objects" do
      @room.create_reservation("2017-03-13", "2017-03-16")
      @room.create_reservation("2017-03-18", "2017-03-20")
      @room.reservations.length.must_equal 2
    end

    it "Raises an error if an invalid date is given" do
      proc { @room.create_reservation("2017-33-13", "2017-03-16").must_raise ArgumentError }
    end

    it "Raises an error if the room is already booked" do
      @room.create_reservation("2017-03-13", "2017-03-16")
      proc { @room.create_reservation("2017-03-13", "2017-03-16").must_raise ArgumentError }
    end

    it "Adds reservation if checking in when another reservation is checking out" do
      @room.create_reservation("2017-03-04", "2017-03-05")
      @room.create_reservation("2017-03-05", "2017-03-19")
      @room.create_reservation("2017-03-19", "2017-03-21")
      @room.reservations.length.must_equal 3
    end
  end

end
