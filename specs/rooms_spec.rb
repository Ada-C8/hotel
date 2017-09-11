require_relative 'spec_helper'

describe "Rooms" do
  describe "#initialize" do
    before do
      @room_1 = HotelHedwig::Rooms.new(1)
    end

# Basic needs tests to access room numbers and the cost.
# Can I do anything else?

    it "Can access a room number." do
      @room_1.room_num.must_equal 1
    end

    it "Can access the cost of a room per night." do
      @room_1.room_cost.must_equal 200
    end
  end
end
