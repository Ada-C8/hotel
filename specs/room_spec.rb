require_relative "spec_helper"

describe "Room class" do
  before do
    @room = Hotel::Room.new
  end

  describe "initialize" do
    it "Creates an instance" do
      @room.must_be_kind_of Hotel::Room
    end

    it "Can access the number and cost" do
      @room.per_night.must_equal 200
      @room.rooms.must_be_instance_of Hash
    end
  end

  describe "all method" do
    it "returns all rooms" do
      @room.all.must_be_instance_of Hash
      @room.all.length.must_equal 20
    end
  end

end
