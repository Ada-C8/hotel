require_relative 'spec_helper'

describe "room" do
  describe "initialize" do
    it "can initialize a new instance of a room" do
      Hotel::Room.new(4).must_be_kind_of Hotel::Room
    end # it "can initialize a new instance of a room" do

    it "will be initialized with a room_number (integer)" do
       Hotel::Room.new(4).room_number.must_be_kind_of Integer
    end # it "will be initialized with a room_number" do

    it "will be initialized with a cost (float)" do
       Hotel::Room.new(4).cost.must_equal 20.0
       Hotel::Room.new(4).cost.must_be_kind_of Float
    end # it "will be initialized with a cost" do

  end # describe "initialize" do
end # describe "room"
