require_relative 'spec_helper'

describe "Room" do
  before do
    @room = Hotel::Room.new()
  end

  describe "initialize" do
    it "Has an available attribute that is initialized to true" do
      @room.available.must_equal true
    end

    it "Has a check_in_date and check_out_date initialized to nil (because it's unreserved yet)" do
    # initializing to nil because a simple Date.new would give you a -4721 BC date,
    # it doesn't make sense to initialize a mock value
      assert_nil(@room.check_in_date)
      assert_nil(@room.check_out_date)
    end

    it "(Wave 1) Returns the cost of the room." do
      @room.cost.must_be_instance_of Integer
      @room.cost.must_equal 200
    end
  end

  describe "self.all" do
    it "Will create a hash composed of the 20 rooms in the hotel" do
      all_rooms = Hotel::Room.all
      all_rooms.must_be_instance_of Hash
      all_rooms.length.must_equal 20
      all_rooms[rand(20) + 1].must_be_instance_of Hotel::Room
      all_rooms.keys[rand(20)].must_be_instance_of Integer
    end
  end

end
