require_relative 'spec_helper'
require_relative '../lib/room'

describe "Room" do
  before do
    @room_test = BookingSystem::Room.new(1, 200.00)
  end

  describe "initialize" do
    it "can create an instance of Room class" do
      @room_test.class.must_equal BookingSystem::Room
    end

    it "#id: can give correct room id number" do
      @room_test.id.must_equal 1
      @room_test.id.must_be_instance_of Integer
    end

    it "#cost: can give correct cost" do
      @room_test.cost.must_equal 200.00
      @room_test.cost.must_be_instance_of Float
    end
  end

  describe "Room.all" do
    it "returns a list of all room instances as an array" do
      all_rooms = BookingSystem::Room.all
      all_rooms.must_be_instance_of Array
    end
  end
end
