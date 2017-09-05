require_relative 'spec_helper'

describe "room" do
  describe "initialize" do
    it "should be an instance of a room" do
      input = Hotel::Room.new(1,200)
      input.must_be_instance_of Hotel::Room
    end
    it "should respond to id" do
      input = Hotel::Room.new(1, 200)
      input.must_respond_to :id
    end
    # it "should have a room number from 1 - 20" do
    #   skip
    #   hotel_rooms = 20.times {Hotel::Room.new}
    #   hotel_rooms.each do |room|
    #     (1..20).must_include room.id
    #   end
    # end
    it "should have a cost" do
      input = Hotel::Room.new(1, 200)
      input.must_respond_to :cost
    end
  end
end
