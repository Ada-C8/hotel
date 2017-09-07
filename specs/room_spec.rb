require_relative 'spec_helper'

describe "Room" do
  describe "initialize" do
    it "Creates a room instance object with a room number" do
      room = ReservationSystem::Room.new(1)

      room.must_be_instance_of ReservationSystem::Room
      room.number.must_equal 1

      another = ReservationSystem::Room.new(100)
      another.number.must_equal 100
    end # "Creates a room instance object with a room number"

    it "Creates a room with a rate of $200" do
      room = ReservationSystem::Room.new(1)

      room.rate.must_equal 200
    end # "Creates a room with a rate of $200"

    it "Creates a room with an empty array of reservations" do
      room = ReservationSystem::Room.new(1)

      room.nights_reserved.must_be_kind_of Array
      room.nights_reserved.must_equal []
    end
  end# "initialize"

end # "Room"
