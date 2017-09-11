require_relative 'spec_helper'

describe "room class" do
  describe "initialize a room" do
    before do
      @room = Room.new(5)
    end
    it "creates a new room object" do
      @room.must_be_instance_of Room
    end

    it "has a room ID that matches user input" do
      @room.id.must_equal 5
    end

    it "has a default status of available" do
      @room.status.must_equal :available
    end

    it "has a default rate of $200 per night" do
      @room.rate.must_equal 200
    end
  end
end
