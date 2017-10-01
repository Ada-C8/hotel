require_relative 'spec_helper'

describe "Block" do
  before do
    @five_rooms = {1 => 150, 2 => 200, 3 => 350, 4 => 120, 5 => 150}
    @check_in = Date.new(2017,10,15)
    @check_out = Date.new(2017,10,17)
    @date_range = BookingSystem::DateRange.new(@check_in, @check_out)
    @new_block = BookingSystem::Block.new(@date_range, @five_rooms)
  end
  describe "#initialize" do
    it "ID should be an integer" do
      @new_block.id.must_be_kind_of Integer
    end
    it "Date_range can be called by .date_range" do
      @new_block.date_range.must_equal @date_range
    end
  end

  describe "#has_available_rooms?" do
    before do
      @five_room_hotel = BookingSystem::Hotel.new(@five_rooms)
      @new_block = @five_room_hotel.create_block(@date_range, 3)
    end
    it "Returns true if there are available rooms in given block" do
      @new_block.has_available_rooms?.must_equal true
    end
    it "Returns false if there is no available rooms in given block" do
      3.times do |i|
        @five_room_hotel.make_reservation_from_block(@new_block, i+1)
      end
      @new_block.has_available_rooms?.must_equal false
    end

    describe "#reserve_room" do
      before do
        @block = @five_room_hotel.create_block(@date_range, 2)
        @block.reserve_room(4)
      end
      it "Booked room should be removed from rooms in block" do
        @block.rooms.length.must_equal 1
      end
      it "Raise an error if requested room is unavailable" do
        proc { @block.reserve_room(4) }.must_raise BookingSystem::NoRoomAvailableError
      end
      it "Raise an error if no available rooms for reservation from block" do
        @block.reserve_room(5)
        proc { @block.reserve_room(4) }.must_raise BookingSystem::NoRoomAvailableError
      end


    end
  end

end #end of describe
