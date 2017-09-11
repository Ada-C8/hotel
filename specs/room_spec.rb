require_relative 'spec_helper'
require_relative '../lib/room'

describe "Room" do
  describe "initialize" do
    it "checks initialize" do
      room = Hotels::Room.new(1)
      room.must_respond_to :room_number
	  room.room_number.must_be_kind_of Integer
	  room.room_number.must_equal 1
    end 
  end
end
