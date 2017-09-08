require_relative 'spec_helper'

describe "Block class" do

  before do
    @min = 1
    @max = 20
    (@min..@max).each { |num| Hotel::Room.new(num) }
  end

  after do
    Hotel::Room.clear
    Hotel::Reservation.clear
    Hotel::Block.clear
  end

  it "can create a block with a date range, collection of rooms, and a discounted room rate" do
    proc{Hotel::Block.new}.must_raise Exception
    proc{Hotel::Block.new("9/17/2017", "9/18/2017", 1)}.must_raise InvalidDateError
    proc{Hotel::Block.new(Date.today, Date.today + 1, 15)}.must_raise ArgumentError
    proc{Hotel::Block.new(Date.today, Date.today + 1, 5, 100)}.must_raise InvalidDiscountError
    # the discount is an optional argument, default set to 0.10
    Hotel::Block.new(Date.today, Date.today + 1, 4).must_be_instance_of Hotel::Block
    Hotel::Block.new(Date.today, Date.today + 1, 4, 0.15).must_be_instance_of Hotel::Block
    x = Hotel::Block.new(Date.today, Date.today + 1, 4, 0.15)
    x.start_date.must_be_instance_of Date
    x.end_date.must_be_instance_of Date
    x.discount.must_be_instance_of Float
    x.rooms.must_be_instance_of Array
    x.rooms.each { |room_num| (@min..@max).to_a.include?(room_num).must_equal true }
  end

  it "only makes blocks with rooms available during the specified date range" do
    ((@min + 4)..@max).each { |num| Hotel::Reservation.new(nil, Date.today, Date.today + 1, num)}
    # can't make a block with more rooms than are available
    proc{Hotel::Block.new(Date.today, Date.today + 1, 5)}.must_raise NoRoomsAvailableError
    # a block will only be made with available rooms
    block = Hotel::Block.new(Date.today, Date.today + 1, 4)
    (@min..(@min+3)).each { |num| block.rooms.include?(num).must_equal true}
  end

  it "prevents blocked rooms from being reserved by the general public" do
    4.times { Hotel::Block.new(Date.today, Date.today + 1, 5) }
    # can't book room in a block without the block_id
    proc { Hotel::Reservation.new(nil, Date.today, Date.today + 1) }.must_raise NoRoomsAvailableError
    # can book a room with the block_id
    Hotel::Reservation.new(1, Date.today, Date.today + 1).must_be_instance_of Hotel::Reservation
  end

  it "prevents a room from being in two blocks at the same time" do
    4.times { Hotel::Block.new(Date.today, Date.today + 1, 5) }
    proc { Hotel::Block.new(Date.today, Date.today + 1, 1) }.must_raise Exception
    Hotel::Block.available(Date.today, Date.today + 1).must_equal []
  end

  it "allows a user to check if a given block has rooms available" do
    # returns an array of unbooked room numbers
    Hotel::Block.new(Date.today, Date.today + 1, 5)
    Hotel::Block.rooms_left(1).must_be_instance_of Array
    Hotel::Block.rooms_left(1).length.must_equal 5

    # once a room is reserved, that is removed from the list of rooms left
    Hotel::Reservation.new(1, Date.today, Date.today + 1)
    Hotel::Block.rooms_left(1).length.must_equal 4
  end

  it "gives a reservation a discount if the room is in a block" do
    block = Hotel::Block.new(Date.today, Date.today + 1, 5, 0.5)
    reservation = Hotel::Reservation.new(block.block_id, Date.today, Date.today + 1)
    reservation.total.must_equal 100
  end

end
