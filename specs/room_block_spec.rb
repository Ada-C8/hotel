require_relative 'spec_helper.rb'

describe "RoomBlock" do

  before do
    @room_block = Hotel::RoomBlock.new("Marcel Luedtke", 2017,9,17, 2017,9,19, 2)
  end

  it "Is a child of Reservation" do
    @room_block.must_be_kind_of Hotel::Reservation
  end

  it "Returns an argument error is the number of rooms reserved is less than 2 or greater than 1" do
    proc {Hotel::RoomBlock.new("Marcel Luedtke", 2017,9,17, 2017,9,19, 1)}.must_raise ArgumentError
    proc {Hotel::RoomBlock.new("Marcel Luedtke", 2017,9,17, 2017,9,19, 6)}.must_raise ArgumentError
  end

  it "has a total method that returns the reservation total minus 20%" do
    @room_block.total.must_equal 640.00
  end

  it "The room price can be set by the administrator" do
    @room_block.room_price = 100
    @room_block.total.must_equal 400
  end

  it "can show the number of rooms available in the block" do
    @room_block.available.must_equal 2
  end

  it "has a reserve method that can book the rooms in the block" do
    @room_block.available.must_equal 2
    @room_block.reserve(1)
    @room_block.available.must_equal 1
    @room_block.reserve(1)
    proc {@room_block.reserve(1)}.must_raise ArgumentError
  end
end
