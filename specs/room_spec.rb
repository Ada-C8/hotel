require_relative 'spec_helper'

describe "Room" do
  before do
    @room = Hotel::Room.new()
  end

  describe "Cost" do
    it "(Wave 1) Returns the cost of the room." do
      @room.cost.must_be_instance_of Integer
      @room.cost.must_equal 200
    end
  end

end
