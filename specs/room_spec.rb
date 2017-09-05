require_relative 'spec_helper'

describe "Room" do
  describe "initialize" do
    it "Creates a room instance object with a room number" do
      room = Hotel::Room.new(1)

      room.must_be_instance_of Hotel::Room
      room.number.must_equal 1

      another = Hotel::Room.new(100) #TODO 1. decide- Testing edge cases... could check for room parameters. Currently allowing rooms to be 'numbered' however.
      another.number.must_equal 100
    end

    it "Creates a room with a rate of $200" do
      room = Hotel::Room.new(1)

      room.rate.must_equal 200
    end

  end
end
