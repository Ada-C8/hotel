require_relative './spec_helper'
require_relative '../lib/rooms'

describe "#rooms" do
  before do
    @my_room = Room.new(21, 200)
    # @my_room.add_reservation("January 4, 2018", "January 10, 2018")
  end

  describe "#methods" do
    it "A new room can be created" do
      @my_room.must_be_instance_of Room
      @my_room.rate.must_equal 200
      @my_room.number.must_equal 21
    end
  end
end
