require_relative 'spec_helper'

describe "Room" do

  before do
    @room = Hotels::Room.new(5)
  end

  describe "#initialize" do
    it "Can be initialized" do
      @room.must_be_instance_of Hotels::Room
    end
    it "Has an ID number" do
      @room.room_id.must_equal 5
    end
    it "Has a price per night that is an Integer" do
      @room.price.must_be_kind_of Integer
    end
  end #------------------------- describe #initialize block
end
