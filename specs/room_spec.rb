require_relative 'spec_helper'
require 'pry'


describe "Hotel" do
  describe "Room" do

    it "has a room number" do
      room_test = Hotel::Room.new(1)
      room_test.must_be_instance_of Hotel::Room
      room_test.number.must_equal 1
      room_test.cost.must_equal 200
    end

  end
end
