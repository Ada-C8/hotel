require_relative "spec_helper"

describe "Room class" do
  before do
    @room = Hotel::Room.new(20,200)
  end

  describe "initialize" do
    it "Creates an instance" do
      @room.must_be_kind_of Hotel::Room
    end

    it "Can access the number and cost" do
      @room.rate.must_equal 200
      @room.room_num.must_equal 20
    end
  end

end
