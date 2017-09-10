require_relative 'spec_helper'

describe "Block Class" do
  before do
    id = 1
    rooms = [Hotel::Room.new(3),Hotel::Room.new(2),Hotel::Room.new(1)]
    date_range = Hotel::DateRange.new(Date.new(2017,3,9),Date.new(2017,3,13))
    @wedding = Hotel::Block.new(id, rooms, date_range, "Royal Wedding")
  end
  it "can be instantiated" do
    @wedding.must_be_kind_of Hotel::Block
    # binding.pry
  end
  it "must respond to all intance variables" do
    @wedding.must_respond_to :id
    @wedding.must_respond_to :total_cost
    @wedding.must_respond_to :rooms
    @wedding.must_respond_to :date_range
    @wedding.must_respond_to :nights
    @wedding.must_respond_to :block_info
    @wedding.must_respond_to :reserved_rooms
  end
  describe "rooms_available_block" do
    it "returns an array with the available rooms" do
      @wedding.rooms_available_block.length.must_equal 3
      @wedding.rooms_available_block.must_be_kind_of Array
    end
    it "returns rooms objects" do
      @wedding.rooms_available_block[0].must_be_kind_of Hotel::Room
    end
  end
  describe "book_room_in_block" do
    it "will raise exception if user tries book more rooms than are available" do
      proc{@wedding.book_room_in_block(4)}.must_raise InvalidRoomQuantity
    end
    it "will return a booking object" do
      @wedding.book_room_in_block(2).must_be_kind_of Hotel::Booking
    end
    it "booking will have correct total_cost" do

    end
  end
end
