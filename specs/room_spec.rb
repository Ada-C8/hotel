require_relative 'spec_helper'

describe "Room" do
  before do
    @room = Hotel::Room.new(20)
  end

  describe "initialize" do

    it "Can create an object of class Room" do
        Hotel::Room.new(1).must_be_instance_of Hotel::Room
        @room.available.must_equal true
    end

    it "(Wave 1) Returns the cost of the room." do
      @room.cost.must_be_instance_of Integer
      @room.cost.must_equal 200
    end
  end

end
