require_relative 'spec_helper'

describe "Block" do

  before do
    avail_block_rooms = [1,2,3,4,5]
    @booking = BookingSystem::Block.new("Bob", '2001-02-03', '2001-02-05', avail_block_rooms)

    @rooms = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    @hotel = BookingSystem::Hotel.new
  end

  describe "#initalize" do
    it "should create a new instance of BookingSystem::Block" do
      @booking.must_be_instance_of BookingSystem::Block

      @booking.must_respond_to :reserved_for
      @booking.reserved_for.must_be_kind_of String
      @booking.reserved_for.must_equal "Bob"

      @booking.must_respond_to :check_in
      #TODO: Must make sure the correct input is given a a regex
      @booking.check_in.must_be_instance_of Date

      @booking.must_respond_to :check_out
      #TODO: Must make sure the correct input is given a a regex
      @booking.check_out.must_be_kind_of Date

      @booking.must_respond_to :avail_block_rooms
      @booking.avail_block_rooms.each do |room_num|
        room_num.must_be_kind_of Integer
      end
      @booking.avail_block_rooms.must_be_kind_of Array
      @booking.avail_block_rooms.length.must_equal 5

      @booking.must_respond_to :reserved_rooms
      @booking.reserved_rooms.must_be_kind_of Array
      @booking.reserved_rooms.must_be_empty

      @booking.must_respond_to :block_total
      @booking.block_total.must_be_kind_of Integer
      @booking.block_total.must_equal 0
    end
  end # Describe

  describe "#block_total" do
    it "should return the discounted total of the rooms that were reserved within the block" do
      @hotel.reserve_block("Bob", '2001-02-03', '2001-02-05', 5)
      @hotel.reserve_room_in_block("Bob", 2)
      @hotel.block_reservations[0].reserve_block_cost
      @hotel.block_reservations[0].block_total.must_equal 600
    end

    it "should return the block total after the rooms were reserved in the Block" do
      @hotel.reserve_block("Bob", '2001-02-03', '2001-02-05', 5)
      @hotel.reserve_room_in_block("Bob", 2)
      block = @hotel.find_requested_block("Bob")
      block.reserve_block_cost.must_equal 600
    end
  end

end # Describe
