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
    it ""
  end
end
