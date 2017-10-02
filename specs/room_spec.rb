require_relative 'spec_helper'

describe "Room Class" do
  before do
    @suite1 = Hotel::Room.new(15)
  end
 it "can be instantiated" do
    room = Hotel::Room.new(15)
    room.must_be_kind_of Hotel::Room
 end
 it "must respond to room_number and cost" do
    @suite1.must_respond_to :room_number
    @suite1.must_respond_to :cost
    @suite1.must_respond_to :booked
 end
  it "cost must equal 200" do
    @suite1.cost.must_equal 200
  end
  it "cost must be a kind of Integer" do
    @suite1.cost.must_be_kind_of Integer
  end
  it "room number must equal room number" do
    @suite1.room_number.must_equal 15
  end
  it "room number must be a kind of Integer" do
    @suite1.room_number.must_be_kind_of Integer
  end
end
