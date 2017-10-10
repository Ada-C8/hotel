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
      @room_1.room_rate.must_equal 200
    end

    it "Must respond to room_num" do
      @room_1.must_respond_to :room_num
    end

    it "Must be instance of HotelHedwig module and Rooms class" do
      @room_1.must_be_instance_of HotelHedwig::Rooms
    end
  end
end
