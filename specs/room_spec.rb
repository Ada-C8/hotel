require_relative 'spec_helper'

describe "Room" do
  describe "initialize" do
    it "can be instantiated" do
      Hotel::Room.new(1, 200).must_be_kind_of Hotel::Room
    end

    it "has a room number" do
      Hotel::Room.new(5, 200).number.must_equal 5
    end

    it "has a cost" do
      Hotel::Room.new(5, 200).cost.must_equal 200
    end
  end
end
