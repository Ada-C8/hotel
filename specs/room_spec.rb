require_relative 'spec_helper'

describe "Room" do
  before do
    @room = Hotel::Room.new(20)
  end

  describe "initialize" do

    it "Can create an object of class Room" do
        Hotel::Room.new(1).must_be_instance_of Hotel::Room
        # initializing to nil because a simple Date.new would give you a -4721 BC date,
        # it doesn't make sense to initialize a mock value
        assert_nil(@room.check_in_date)
        assert_nil(@room.check_out_date)
        @room.available.must_equal true
    end

    it "(Wave 1) Returns the cost of the room." do
      @room.cost.must_be_instance_of Integer
      @room.cost.must_equal 200
    end
  end

  describe "self.create_rooms" do
    it "Will create an array composed of the 20 rooms in the hotel" do
      all_rooms = Hotel::Room.create_rooms
      all_rooms.must_be_instance_of Array
      all_rooms.length.must_equal 20
      all_rooms[rand(20)].must_be_instance_of Hotel::Room
    end
  end

end
