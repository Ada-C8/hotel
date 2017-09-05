require_relative "spec_helper"

describe "Room class" do
  it "creates an instance of room" do
    Hotel::Room.new(1).must_be_kind_of Hotel::Room
  end
  it "must respond to :num" do
    Hotel::Room.new(1).must_respond_to :num
  end
end
describe "Room.all" do
  it "is an instance of Array" do
    Hotel::Room.all.must_be_instance_of Array
  end
end
