require_relative 'spec_helper'

describe Hotel::Room do
  describe "You can create a Room instance" do
    it "Can be created" do
      room = Hotel::Room.new(1)
      room.must_be_instance_of Hotel::Room
    end
    it "raises an ArgumentError for invalid parameters" do
      proc{Hotel::Room.new("A15")}.must_raise ArgumentError
    end
    it "raies an ArgumentError if the room number already exists" do

    end
  end

  describe "atribute_readers" do
    it "can retrieve the room number using .number" do
      room = Hotel::Room.new(5)
      room.number.must_equal 5
    end
  end
end
