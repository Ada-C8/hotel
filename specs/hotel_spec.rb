require_relative 'spec_helper'
require_relative '../lib/hotel'

# describe "Rooms" do
#   before do
#     @rooms = Hotel::Hotel_Rooms.new(1)
#   end
#
#   it "can initialize rooms" do
#     @rooms.must_be_instance_of Hotel::Hotel_Rooms
#     @rooms.number.must_be_kind_of Integer
#     #@rooms.room_id.must_equal 1
#   end

  describe "Room" do
    describe "initialize" do
      it "checks initialize" do
        room = Hotel::Hotel_Rooms.new(1)
        room.must_respond_to :room_number
  	  room.room_number.must_be_kind_of Integer
  	  room.room_number.must_equal 1
      end
    end
  end
