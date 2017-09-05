require_relative 'spec_helper'

describe "Room" do
  describe "initialize" do
    it "Creates a room instance object with a room number" do
      room = Hotel::Room.new(1)

      room.must_be_instance_of Hotel::Room
      room.number.must_equal 1
    end

    it "Creates a room with a rate" do

    end

  end
end
