require_relative 'spec_helper'

describe 'Room' do
  before do
    @new_room = Hotel::Room.new("1")
  end
  describe 'initialize' do
    it "must be an instance of Room" do
      @new_room.must_be_instance_of Hotel::Room
    end
  end

  describe 'room number' do

    it "must have a room number" do
      @new_room.must_respond_to :room_number
    end
    it "must output its correct room number" do
      @new_room.room_number.must_equal "1"
    end
  end

  describe 'room rate' do
    it "must have a designated room rate" do
      @new_room.must_respond_to :room_rate
    end
    it "must default to 200" do
      @new_room.room_rate.must_equal 200
    end
  end
end
